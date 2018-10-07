class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
    	t.integer :patient_id, index: true
    	t.integer :provider_id, index: true
    	t.time :start_time
    	t.time :end_time
    	t.date :date

      t.timestamps
    end
  end
end
