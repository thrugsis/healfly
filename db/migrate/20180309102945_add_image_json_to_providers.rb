class AddImageJsonToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :image, :json

  end
end
