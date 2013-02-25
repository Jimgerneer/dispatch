class AddMinecraftNameToUser < ActiveRecord::Migration
  def change
    add_column :users, :minecraft_name, :string
  end
end
