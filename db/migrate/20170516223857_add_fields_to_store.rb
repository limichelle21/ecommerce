class AddFieldsToStore < ActiveRecord::Migration
  def change
      add_column :stores, :description, :text
      add_column :stores, :about, :text
      add_column :stores, :action_call, :text
  end
end
