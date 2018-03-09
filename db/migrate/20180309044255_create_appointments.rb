class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
    	t.references :user, foreign_key: true
    	t.references :provider, foreign_key: true
    	t.time :start_time
    	t.time :end_time
    	t.date :date

      t.timestamps
    end
  end
end
