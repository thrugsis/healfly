class CreateProviders < ActiveRecord::Migration[5.0]
  def change
    create_table :providers do |t|
      t.integer :price, null: false
      t.string :location, null: false
      t.string :name, null: false
      t.string :treatment, null: false
      t.string :language, null: false
      t.text :image, null: false
      t.text :qualification, null: false

      t.timestamps
    end
  end
end
