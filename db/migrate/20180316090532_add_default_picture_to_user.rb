class AddDefaultPictureToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :default_picture, :string
  end
end
