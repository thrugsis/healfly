class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :password
      t.string :encrypted_password, limit: 128
      t.string :remember_token, limit: 128
      t.string :confirmation_token, limit: 128
      t.string :gender
      t.string :phone_number
      t.date :birthday
      t.text :image
      t.text :medical_history

      t.timestamps
    end
    add_index :users, :email
    add_index :users, :remember_token
  end
end
