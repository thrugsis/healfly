class RemoveImageFromProviders < ActiveRecord::Migration[5.0]
  def change
    remove_column :providers, :image

  end
end
