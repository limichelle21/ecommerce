class AddOrderToOrderLines < ActiveRecord::Migration
  def change
  	add_column :order_lines, :order_id, :integer
  	add_index :order_lines, :order_id
  end
end
