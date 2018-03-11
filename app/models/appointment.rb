class Appointment < ApplicationRecord
	belongs_to :user, required: false
	belongs_to :provider, required: false
end
