class CreateSpecies < ActiveRecord::Migration
  def change
    create_table :species do |t|
      t.references :statuses
      t.references :shrines
      t.string :name
      t.string :scientific_name
      t.text :description
      t.string :country
      t.text :habitat
      t.text :nutrition
      t.string :population
      t.text :threats
      t.string :picture
      t.string :need

      t.timestamps null: false
    end
  end
end
