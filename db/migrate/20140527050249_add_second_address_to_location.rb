class AddSecondAddressToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :second_address, :string
  end
end
