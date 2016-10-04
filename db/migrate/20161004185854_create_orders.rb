class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :restaurant, foreign_key: true
      t.integer :state

      t.timestamps
    end
  end
end
