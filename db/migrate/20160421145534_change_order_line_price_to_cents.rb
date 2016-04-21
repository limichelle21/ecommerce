class ChangeOrderLinePriceToCents < ActiveRecord::Migration
  def change
  	rename_column :order_lines, :price, :price_in_cents
  	change_column :order_lines, :price_in_cents, :integer
  end
end
