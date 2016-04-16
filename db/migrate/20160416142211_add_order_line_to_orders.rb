class AddOrderLineToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :order_line_id, :integer
  	add_index :orders, :order_line_id
  end
end
