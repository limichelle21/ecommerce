class ChangePriceToCents < ActiveRecord::Migration
  def change
  	rename_column :products, :price, :price_in_cents
  	change_column :products, :price_in_cents, :integer
  end
end
