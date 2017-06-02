class ChangeAvatarToImage < ActiveRecord::Migration
  def change
    rename_column :products, :avatar, :image
  end
end
