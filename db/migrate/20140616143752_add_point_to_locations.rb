class AddPointToLocations < ActiveRecord::Migration
  def change
    change_table :locations do |t|
      t.point :lonlat, geographic: true
      t.index :lonlat, spatial: true
    end
  end
end
