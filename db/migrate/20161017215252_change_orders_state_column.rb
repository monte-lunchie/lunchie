class ChangeOrdersStateColumn < ActiveRecord::Migration[5.0]
  def up
    change_column :orders, :state, :integer, default: 0
  end

  def down
    change_column :orders, :state, :integer, default: nil
  end
end
