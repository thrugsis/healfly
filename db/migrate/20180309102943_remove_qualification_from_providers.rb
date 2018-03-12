class RemoveQualification < ActiveRecord::Migration
  def change
    remove_column :providers, :qualification

  end
end
