class AddStoreToOwner < ActiveRecord::Migration
  def change
  	add_column :users, :store_id, :integer
  end
end


# if an Owner is a USER type, can we associate a STORE to an OWNER or a USER? 
