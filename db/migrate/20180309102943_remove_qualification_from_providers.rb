class RemoveQualificationFromProviders < ActiveRecord::Migration[5.0]
class RemoveQualificationFromProviders < ActiveRecord::Migration
  def change
    remove_column :providers, :qualification

  end
end
