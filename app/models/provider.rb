class Provider < ApplicationRecord
	has_many :appointments, :dependent => :delete_all


  mount_uploaders :image, ImageUploader
  mount_uploaders :qualification, QualificationUploader
  
  def provider?
    has_role?(:provider)
  end

  include PgSearch
  pg_search_scope :search_engine, :against => [:treatment, :location]

end
