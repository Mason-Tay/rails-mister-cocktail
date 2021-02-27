class CreateCocktails < ActiveRecord::Migration[6.0]
  def change
    create_table :cocktails do |t|
      t.string :name
      t.text :description
      t.integer :rating
      t.text :image

      t.timestamps
    end
  end
end
