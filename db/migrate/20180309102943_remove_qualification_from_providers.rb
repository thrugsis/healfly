class RemoveQualificationFromProviders < ActiveRecord::Migration[5.0]
  def change
    remove_column :providers, :qualification

  end
end
