class Provider < ApplicationRecord
	has_many :appointments, :dependent => :delete_all

  def provider?
    has_role?(:provider)
  end
end
