class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :email
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :phone_number

      t.timestamps null: false
    end
  end
end
