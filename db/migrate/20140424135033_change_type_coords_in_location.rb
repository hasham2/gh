class ChangeTypeCoordsInLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :lat
    remove_column :locations, :lng
    add_column :locations, :lat, :float
    add_column :locations, :lng, :float
  end
end
