class AddEnrollFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :enrollment_complete,  :boolean, default: false
  end
end
