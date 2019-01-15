# Healfly, affordable international health services


<img src="https://cdn.svgporn.com/logos/ruby.svg" alt="Ruby Icon" width="75" height="75"/>
<img src="https://cdn.svgporn.com/logos/html-5.svg" alt="html Icon" width="75" height="75"/>
<img src="https://cdn.svgporn.com/logos/css-3.svg" alt="css Icon" width="75" height="75"/>
<img src="https://cdn.svgporn.com/logos/javascript.svg" alt="js Icon" width="75" height="75"/>
<img src="https://cdn.svgporn.com/logos/postgresql.svg" alt="pg Icon" width="75" height="75"/>
<img src="https://cdn.svgporn.com/logos/aws.svg" alt="aws Icon" width="75" height="75"/>
<img src="https://cdn.svgporn.com/logos/rails.svg" alt="Rails Icon" width="75" height="75"/>
<img src="https://cdn.svgporn.com/logos/jquery.svg" alt="jquery Icon" width="75" height="75"/>
<img src="https://cdn.svgporn.com/logos/stripe.svg" alt="stripe Icon" width="75" height="75"/>


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
[Routes](https://github.com/GeorgeBelanger/healfly#Routes)<br/>





**This app was created as an 5 member agile team using a KanBan board, Slack and GitHub. It has 14 different Git branches for each of the features that were developed:**

> Appointments  |  Authorizations   |  Stripe   |   Default Picture Uploader   |   Clearance   |   Facebook Login     |  Mailer    |   Homepage Design   |    Login Modal   |   Search Homepage    





## User Authentication with Facebook


## Practitioner Service Offerings

  Practitioners can add a default picture, medical certifications and other photos to their profile. Users can also upload their photos and medical history. 
  
  This is made easy using AWS S3, Fog, Carrierwave and custom uploaders. In `config\initializers\carrierwave.rb` and `app\uploaders\image_uploader.rb` respectively: 

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

## Appointments

## Calendar Reservations

## Email Notifications

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



## Routes



Nice little side note: had to change the default email in `app\mailers\application_mailer.rb` to healflymail@gmail.com and turn on 'allow less secure apps' at [https://www.google.com/settings/security/lesssecureapps](https://www.google.com/settings/security/lesssecureapps) and also go to [https://accounts.google.com/b/0/DisplayUnlockCaptcha](https://accounts.google.com/b/0/DisplayUnlockCaptcha) to allow unlock capchas for 10 minutes. 


The key features of this app include 

  1. User login and authentication with email or Facebook
  2. Practitioner service offering creation and photo upload 
  3. Filtering based on service, price, location and/or language using PG Search
  4. Appointment creation with payment 
  5. Calendar reservation and blocking 
  6. Notification email 
  7. Store everything in a PostGre SQL database
