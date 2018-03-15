class AddColumnToAppointments < ActiveRecord::Migration[5.0]
  def change
    add_column :appointments, :payment_status, :boolean, :default => false
    add_column :appointments, :payment_amount, :integer
  end
end
