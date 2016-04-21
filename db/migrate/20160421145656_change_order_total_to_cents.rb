class ChangeOrderTotalToCents < ActiveRecord::Migration
  def change
  	rename_column :orders, :total, :price_in_cents
  	change_column :orders, :price_in_cents, :integer
  end
end
