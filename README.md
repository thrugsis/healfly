# Healfly, affordable international health services


<img src="https://cdn.svgporn.com/logos/ruby.svg" alt="Ruby Icon" width="75" height="75"/><img src="https://cdn.svgporn.com/logos/html-5.svg" alt="html Icon" width="75" height="75"/><img src="https://cdn.svgporn.com/logos/css-3.svg" alt="css Icon" width="75" height="75"/><img src="https://cdn.svgporn.com/logos/javascript.svg" alt="js Icon" width="75" height="75"/><img src="https://cdn.svgporn.com/logos/postgresql.svg" alt="pg Icon" width="75" height="75"/><img src="https://cdn.svgporn.com/logos/aws.svg" alt="aws Icon" width="75" height="75"/><img src="https://cdn.svgporn.com/logos/rails.svg" alt="Rails Icon" width="75" height="75"/><img src="https://cdn.svgporn.com/logos/jquery.svg" alt="jquery Icon" width="75" height="75"/><img src="https://cdn.svgporn.com/logos/stripe.svg" alt="stripe Icon" width="75" height="75"/>


### The idea behind this app was to have a listing of affordable health service providers around the world. The cost of healthcare procedures in the USA is several times higher than in other countries: 

<img src="https://medicaltourism.com/Content/images/Jordan/tbl1.jpg" alt="Costs of procedures internationally"/>

## Table of Contents

[User Authentication with Facebook](https://github.com/GeorgeBelanger/healfly#User-Authentication-with-Facebook)<br/>
[Practitioner Service Offerings and Image Upload](https://github.com/GeorgeBelanger/healfly#Practitioner-Service-Offerings-and-image-upload)<br/>
[Database Search Filtering](https://github.com/GeorgeBelanger/healfly#Database-Search-Filtering)<br/>
[Appointments](https://github.com/GeorgeBelanger/healfly#Appointments) <br/>
[Calendar Reservations](https://github.com/GeorgeBelanger/healfly#Calendar-Reservations)<br/>
[Email Notifications](https://github.com/GeorgeBelanger/healfly#Email-Notifications)<br/>
[Postgre SQL Database](https://github.com/GeorgeBelanger/healfly#Postgre-SQL-Database)<br/>




**This app was created by a 5 member agile team using a KanBan board, Slack and GitHub. It has 14 different Git branches for each of the features that were developed:**

> Appointments  |  Authorizations   |  Stripe   |   Default Picture Uploader   |   Clearance   |   Facebook Login     |  Mailer    |   Homepage Design   |    Login Modal   |   Search Homepage    





## User Authentication with Facebook

For authentications, we use clearance to log in with email or with omniauth and facebook. In the sessions controller, it checks if the user has logged into our app with facebook before or creates a new user. 

```ruby
def create_from_omniauth
    auth_hash = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

    # if: previously already logged in with OAuth
    if authentication.user
      user = authentication.user
      authentication.update_token(auth_hash)
      @next = root_url
      @notice = "Signed in!"
    # else: user logs in with OAuth for the first time
    else
      user = User.create_with_auth_and_hash(authentication, auth_hash)
      # you are expected to have a path that leads to a page for editing user details
      @next = verification_path(user)
      @notice = "user created"
    end

    sign_in(user)
    redirect_to @next, :notice => @notice
```
Clearance uses Bcrypt to store the encrypted(salted) passwords and tokens in the users table. 

To explain salt and hash, Bcrypt is a hashing service. It takes a string and creates a long jumbled string based on the characters in our original string(read: password.) The problem with storing just this is that if someone got our password hash, they can run bcrypt in reverse and get our password. That is where salt comes in. Salt is a random string that is added to our original password before it is run in bcrypt. Clearance stores the salt and adds it to our original password before it runs them in bcrypt and checks the result against our originally salted hash, so even if someone got our encrypted password, they'd have to get the salt as well to get our original password. 

## Practitioner Service Offerings

  Practitioners can add a default picture, medical certifications and other photos to their profile. Users can also upload their photos and medical history. 
  
  The path the image upload takes is:

  > view `https://healfly.herokuapp.com/providers/n/edit` > @provider controller > @provider model > image_uploader > fog/carrierwave > AWS returns url > @provider SQL info updated through controller


  This is made easy using AWS S3, Fog, Carrierwave and custom uploaders.   In `config\initializers\carrierwave.rb` and `app\uploaders\image_uploader.rb` respectively: 
  

```ruby
  # carrierwave.rb

  config.fog_provider = 'fog/aws'                        # required
  config.fog_credentials = {
    provider:              'AWS',                        # required
    aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
    aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
    region:                'ap-southeast-1'  
                          # required
    }
  config.fog_directory  = 'healfly-photos'      


  # image_uploader.rb

  class ImageUploader < CarrierWave::Uploader::Base

  storage :fog

  def extension_whitelist
    %w(jpg jpeg gif png webp)
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

```      

  We use figaro to hide the environment variables. 

## Database Search Filtering

To filter our database to the users desired service, location, language and price, we do a full-text in our PostGre SQL Database using PG Search. It uses active record's scopes so the treatments and the languages don't end up in the location search and vice versa. For example below:

`scope :treatment, -> (input_treatment) { where("treatment ILIKE ?", "%#{input_treatment}%") }`

First we use the ? placeholder to stop SQL injection into our database. This works because if we just did the raw term, people could put quotes in, stoping our code short and inject their own sql queries. The ? evaluates every character they type as part of the value and it won't be parsed as SQL regardless of quotes.

The SQL ILIKE operator treats %'s like wildcards, so anything that has your search term before, after or in between it will match. If you typed in 'back surgery' then it would return a result that was 'Austrian back surgery operations'.

In `app\models\provider.rb`

```ruby
include PgSearch
  pg_search_scope :search_engine, :against => [:treatment, :location]
  scope :treatment, -> (input_treatment) { where("treatment ILIKE ?", "%#{input_treatment}%") }
  scope :location, -> (input_location) { where("location ILIKE ?", "%#{input_location}%") }
  scope :language, -> (input_language) { where("language ILIKE ?", "%#{input_language}%") }
```

## Appointments

Appointments are made between providers and patients. They have a start and end time and a payment status to know weather to block the time-range in the calendar and send confirmation emails. 

## Calendar Reservations

Reservations are done using flatpickr, a link to which we have in the head of the application. It fills in our `<p> <%= s.label :date, "Date" %> <%= s.text_field :date, id:"dateAppoint"%> </p>` form for our provider, patient and appointment with the correct dates, picked from a UI calender. 

## Email Notifications

Emails are sent for signing up, scheduling an appointment and for completing a payment. This is done using an SMTP server that is built into Ruby. We just plug in our email, pw, and then the mailer takes our email template and fills it in with the correct data. 

In `app\mailers\appointment_mailer.rb`

```ruby 
def appointment_email(user, provider, appointment)
  @user = user
  @url = "https://healfly.herokuapp.com/"
  @provider = provider
  @appointment = appointment
  mail(to: @user.email, subject: 'Your appointment has been created, thank you')
end

def payment_email(user, appointment)
  @user = user
  @appointment = appointment
  @url = "https://healfly.herokuapp.com/"
  mail(to: @user.email, subject: 'Thank you for your payment')
end
```

In `config\environments\production.rb`

```ruby
config.action_mailer.default_url_options = { host: 'https://healfly.herokuapp.com/' }
config.action_mailer.raise_delivery_errors = true
config.action_mailer.delivery_method = :smtp
config.action_mailer.perform_deliveries = true
config.action_mailer.default_options = {from: 'healflymail@gmail.com'}
config.action_mailer.smtp_settings = {
  address:              'smtp.gmail.com',
  port:                 587,
  user_name:            'healflymail@gmail.com',
  password:             ENV["GMAIL_PASSWORD"],
  authentication:       'plain',
  enable_starttls_auto: true  }
```
## Postgre SQL Database

Here is the schema for our database which can be found in `db\schema.rb`

| Appointments   | Authentications | Users               |
|:--------------:|:---------------:|:-------------------:|  
| patient_id     | uid             | username            |
| provider_id    | token           | first_name          |
| start_time     | provider        | last_name           |
| end_time       | user_id         | email               |
| date           | created_at      | encrypted_password  |
| created_at     | updated_at      | remember_token      |
| updated_at     |                 | confirmation_token  |
| payment_status |                 | gender              |
| payment_amount |                 | phone_number        |
|                |                 | birthday            |
|                |                 | image               |
|                |                 | medical_history     |
|                |                 | price               |
|                |                 | location            |
|                |                 | name                |
|                |                 | treatment           |
|                |                 | language            |
|                |                 | qualification       |
|                |                 | type                |
|                |                 | created_at          |
|                |                 | updated_at          |
|                |                 | provider            | 
|                |                 | uid                 |
|                |                 | fb_picture          |
|                |                 | profile_picture     |


