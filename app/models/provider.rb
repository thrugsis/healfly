class Provider < ApplicationRecord
	has_many :appointments, :dependent => :delete_all
  
  def provider?
    has_role?(:provider)
  end

  scope :treatment, -> (input_treatment) { where("treatment ILIKE ?", "%#{input_treatment}%") }
  scope :location, -> (input_location) { where("location ILIKE ?", "%#{input_location}%") }
  scope :language, -> (input_language) { where("language ILIKE ?", "%#{input_language}%") }


end
