class AddMoreFieldsToEmployer < ActiveRecord::Migration
  def change
    add_column :employers, :description, :text
    add_column :employers, :formation_year, :date
    add_column :employers, :additional_information, :text
  end
end
