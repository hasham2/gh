class AddFieldToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :other_industry, :string
  end
end
