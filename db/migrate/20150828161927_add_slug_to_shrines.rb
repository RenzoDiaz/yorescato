class AddSlugToShrines < ActiveRecord::Migration
  def change
  	add_column :shrines, :slug, :string
    add_index    :shrines, :slug , unique: true
  end
end
