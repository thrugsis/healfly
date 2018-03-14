class Appointment < ApplicationRecord
	belongs_to :patient, class_name: "Patient", foreign_key: "patient_id"
	belongs_to :provider, class_name: "Provider", foreign_key: "provider_id"

  def payment_update(amount)
    self.update_attributes(payment_status: "Paid", payment_amount: amount)
  end
end
