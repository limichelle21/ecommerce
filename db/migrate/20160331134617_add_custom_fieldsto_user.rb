class AddCustomFieldstoUser < ActiveRecord::Migration
  def change
  	add_column :users, :type, :string
  	add_column :users, :name, :string
  	add_column :users, :username, :string
  	add_column :users, :address_1, :string
  	add_column :users, :address_2, :string
  	add_column :users, :phone_number, :string
  end
end
