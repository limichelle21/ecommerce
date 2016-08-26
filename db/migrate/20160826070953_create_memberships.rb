class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.integer :customer_id
      t.integer :store_id

      t.timestamps null: false
    end
  end
end
