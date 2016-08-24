class AddChargeToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :charge_id, :integer
  end
end

