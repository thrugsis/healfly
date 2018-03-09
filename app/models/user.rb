class User < ApplicationRecord
  include Clearance::User

  has_many :appointments, :dependent => :delete_all
end
