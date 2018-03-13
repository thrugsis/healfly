
class Provider < User
	has_many :appointments, :dependent => :destroy
	has_many :appointments, :dependent => :delete_all


  mount_uploaders :image, ImageUploader
  mount_uploaders :qualification, QualificationUploader
  
  def provider?
    self.type == "Provider"
  end

  include PgSearch
  pg_search_scope :search_engine, :against => [:treatment, :location]
  scope :treatment, -> (input_treatment) { where("treatment ILIKE ?", "%#{input_treatment}%") }
  scope :location, -> (input_location) { where("location ILIKE ?", "%#{input_location}%") }
  scope :language, -> (input_language) { where("language ILIKE ?", "%#{input_language}%") }

end
