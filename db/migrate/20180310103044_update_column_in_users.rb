class UpdateColumnInUsers < ActiveRecord::Migration[5.0]
  def change
    change_column_null :users, :password, false
  end
end
