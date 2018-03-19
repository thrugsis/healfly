class AddFbPictureToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :fb_picture, :string
  end
end
