class User < ApplicationRecord
  include Clearance::User
  has_many :appointments, :dependent => :delete_all
  has_many :images
  has_many :authentications, :dependent => :destroy

  scope :patients, -> { where(type: 'Patients')}
  scope :providers, -> { where(type: 'Providers')}

 def self.create_with_auth_and_hash(authentication, auth_hash)
   user = self.create!(
     name: auth_hash["info"]["name"],
     username: auth_hash["info"]["name"],
     first_name: auth_hash["info"]["name"],
     last_name: auth_hash["info"]["name"],
     default_picture: auth_hash["info"]["image"],
     email: auth_hash["extra"]["raw_info"]["email"],
     type: "Patient",
     password: SecureRandom.base64
   )
   user.authentications << authentication
   return user
 end

 # grab fb_token to access Facebook for user data
 def fb_token
   x = self.authentications.find_by(provider: 'facebook')
   return x.token unless x.nil?
 end

 def patient?
    self.type == "Patient"
  end

  def provider?
    self.type == "Provider"
  end

end
