class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.decimal :total
      t.boolean :completed
      t.datetime :date_paid

      t.timestamps null: false
    end
  end
end
