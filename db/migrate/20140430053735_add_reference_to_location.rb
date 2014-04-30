class AddReferenceToLocation < ActiveRecord::Migration
  def change
  	add_column :locations, :locateable_id, :integer
  	add_column :locations, :locateable_type, :string
  end
end
