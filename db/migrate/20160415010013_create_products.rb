class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :sku
      t.decimal :price
      t.integer :count

      t.timestamps null: false
    end
  end
end
