class AddFieldToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :other_industry, :string
    add_column :employers, :business_phone, :string
  end
end
