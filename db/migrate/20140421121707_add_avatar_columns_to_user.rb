class AddAvatarColumnsToUser < ActiveRecord::Migration
  def self.up
    add_attachment :users, :avatar
    add_column :users, :company_name, :string
  end
  def self.down
    remove_attachment :users, :avatar
    remove_column :users, :company_name, :string
  end
end
