class AddNewFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_primary, :string
    add_column :users, :phone_secondary, :string
    add_column :users, :birth_year, :string
    add_column :users, :gender, :integer
    add_column :users, :criminal_convictions, :integer
    add_column :users, :drivers_licence, :integer
    add_column :users, :drivers_licence_class, :integer
    add_column :users, :has_vehicle, :integer
    add_column :users, :car_pool, :integer
  end
end
