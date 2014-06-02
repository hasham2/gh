class AddFieldToUser < ActiveRecord::Migration
  def change
    add_column :users, :credit_score, :integer
  end
end
