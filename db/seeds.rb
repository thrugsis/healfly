# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

patient = {}


#ActiveRecord::Base.transaction will rollback if there is an error (by raising an acception - create! or save!)
ActiveRecord::Base.transaction do
 20.times do
    patient['username'] = Faker::Name.first_name
    patient['first_name'] = Faker::Name.first_name
  patient['last_name'] = Faker::Name.last_name
    patient['email'] = Faker::Internet.email
	patient['gender'] = ["Male", "Female"].at(rand(2))
	patient['phone_number'] = Faker::PhoneNumber.phone_number
  patient['birthday'] = Faker::Date.between(100.years.ago, 18.years.ago)
  patient['image'] = Faker::LoremPixel.image("500x500", false, 'people')
  patient['medical_history'] = Faker::LoremPixel.image("500x500", false, 'business')

   Patient.create(patient)
 end
end



provider = {}

#ActiveRecord::Base.transaction will rollback if there is an error (by raising an acception - create! or save!)
ActiveRecord::Base.transaction do
 20.times do 
  provider['username'] = Faker::Name.first_name
    provider['first_name'] = Faker::Name.first_name
  provider['last_name'] = Faker::Name.last_name
    provider['email'] = Faker::Internet.email
    provider['price'] = rand(10..20)
    provider['name'] = Faker::Company.name
    provider['location'] = Faker::Address.country
	provider['treatment'] = Faker::Lorem.sentence($nbWords = 6, $variableNbWords = true)
	provider['language'] = Faker::Address.country_code
	provider['qualification'] = Faker::LoremPixel.image("500x500", false, 'technics')
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
