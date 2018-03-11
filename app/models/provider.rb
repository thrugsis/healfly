class Provider < ApplicationRecord
	has_many :appointments, :dependent => :destroy
end
