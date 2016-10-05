class CreateMeals < ActiveRecord::Migration[5.0]
  def change
    create_table :meals do |t|
      t.references :restaurant
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end
