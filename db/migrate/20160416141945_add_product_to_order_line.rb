class AddProductToOrderLine < ActiveRecord::Migration
  def change
  	add_column :order_lines, :product_id, :integer
  	add_index :order_lines, :product_id
  end
end
