class AddOrderToGuests < ActiveRecord::Migration

  def change
  	add_column :guests, :order_id, :integer
  end

end
