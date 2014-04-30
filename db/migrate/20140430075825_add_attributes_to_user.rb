class AddAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :phone_primary, :integer
    add_column :users, :phone_secondary, :integer
    add_column :users, :birth_year, :date
    add_column :users, :gender, :boolean
    add_column :users, :skillset, :string
    add_column :users, :criminal_convictions, :string
    add_column :users, :driver_licence, :string
    add_column :users, :licence_class, :string
    add_column :users, :has_vehicle, :boolean
    add_column :users, :car_pool, :integer
  end
end
