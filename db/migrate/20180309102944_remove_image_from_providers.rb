class RemoveImage < ActiveRecord::Migration
  def change
    remove_column :providers, :image

  end
end
