class CreateOrderLines < ActiveRecord::Migration
  def change
    create_table :order_lines do |t|
      t.integer :quantity
      t.decimal :price

      t.timestamps null: false
    end
  end
end
