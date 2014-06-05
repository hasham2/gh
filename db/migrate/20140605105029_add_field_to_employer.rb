class AddFieldToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :business_phone, :string
  end
end
