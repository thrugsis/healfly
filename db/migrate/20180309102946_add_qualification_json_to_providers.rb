class AddQualificationJsonToProviders < ActiveRecord::Migration
  def change
    add_column :providers, :qualification, :json

  end
end
