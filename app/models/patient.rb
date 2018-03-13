class Patient < User

  has_many :appointments, :dependent => :delete_all

  mount_uploaders :image, ImageUploader
  mount_uploaders :medical_history, MedicalHistoryUploader

end