# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = {}


#ActiveRecord::Base.transaction will rollback if there is an error (by raising an acception - create! or save!)
ActiveRecord::Base.transaction do
 20.times do
    user['username'] = Faker::Name.first_name
    user['email'] = Faker::Internet.email
    user['first_name'] = Faker::Name.first_name
	user['last_name'] = Faker::Name.last_name
  user['password'] = Faker::Color.color_name
	user['gender'] = ["Male", "Female"].at(rand(2))
	user['image'] = Faker::LoremPixel.image("500x500", false, 'people')
	user['birthday'] = Faker::Date.between(100.years.ago, 18.years.ago)
	user['phone_number'] = Faker::PhoneNumber.phone_number

   User.create(user)
 end
end

provider = {}

#ActiveRecord::Base.transaction will rollback if there is an error (by raising an acception - create! or save!)
ActiveRecord::Base.transaction do
 20.times do
    provider['price'] = rand(10..20)
    provider['name'] = Faker::Company.name
    provider['location'] = Faker::Address.country
	provider['treatment'] = Faker::Lorem.sentence($nbWords = 6, $variableNbWords = true)
	provider['language'] = Faker::Address.country_code
	provider['qualification'] = Faker::Lorem.sentence($nbWords = 6, $variableNbWords = true)
	provider['image'] = Faker::LoremPixel.image("500x500", false, 'people') 

   Provider.create(provider)
 end
end

appointment = {}

ActiveRecord::Base.transaction do
 20.times do
    appointment['date'] = Faker::Date.between(Date.today, 1.year.from_now)
    appointment['start_time'] = Faker::Time.between(appointment['date'], appointment['date'] + 24 * 60 * 60, :all)
    appointment['end_time'] = appointment['start_time'] + 2*60*60
    appointment['user_id'] = rand(1..20)
	appointment['provider_id'] = rand(1..20)
	
   Appointment.create(appointment)
 end
end
