class ChangeChargeIdtoString < ActiveRecord::Migration
  def change
    change_column :orders, :charge_id, :string
  end
end
