class AddProfilePictureJsonToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :profile_picture_json, :json
  end
end
