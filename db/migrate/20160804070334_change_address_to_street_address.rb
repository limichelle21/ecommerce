class ChangeAddressToStreetAddress < ActiveRecord::Migration
  def change
  	rename_column :users, :address_1, :street_address
  	rename_column :users, :address_2, :city
  	add_column :users, :state, :string
  	add_column :users, :zip_code, :string
  end
end
