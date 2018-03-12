class Provider < ApplicationRecord

	has_many :appointments, :dependent => :destroy
	has_many :appointments, :dependent => :delete_all
  
  def provider?
    has_role?(:provider)
  end

  include PgSearch
  pg_search_scope :search_engine, :against => [:treatment, :location]
  
  	mount_uploader :image, AvatarUploader
end
