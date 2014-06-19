class AddApproximateAddressToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :approximate_address, :boolean
  end
end
