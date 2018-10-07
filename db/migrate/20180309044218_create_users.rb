class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      #patients
      t.string :username, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :encrypted_password, limit: 128 #no need password column since clearance will auto look at encrypted_password
      t.string :remember_token, limit: 128
      t.string :confirmation_token, limit: 128
      t.string :gender
      t.string :phone_number
      t.date :birthday
      t.string :image
      t.string :medical_history

      #providers (will share username, first_name, last_name, email and password)
      t.integer :price
      t.string :location
      t.string :name
      t.string :treatment
      t.string :language
      t.string :qualification

      #Single Table Inheritance Type
      t.string :type, null: false
      

      t.timestamps
    end
    
  end
end
