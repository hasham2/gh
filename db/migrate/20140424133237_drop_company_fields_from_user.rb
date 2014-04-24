class DropCompanyFieldsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :company_name
    remove_column :users, :company_phone
    remove_column :users, :company_website
  end
end
