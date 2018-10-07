class AddColumnToAppointments < ActiveRecord::Migration
  def change
    add_column :appointments, :payment_status, :boolean, :default => false
    add_column :appointments, :payment_amount, :integer
  end
end
