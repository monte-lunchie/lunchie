class AddCreatorToOrder < ActiveRecord::Migration[5.0]
  def change
    add_reference :orders, :creator, foreign_key: { to_table: :users }
  end
end
