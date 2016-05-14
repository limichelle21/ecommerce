class ChangeOwnerIdToStoreIdOnProducts < ActiveRecord::Migration
  def change
  	rename_column :products, :owner_id, :store_id
  end
end
