class RemoveTimezoneFromLocation < ActiveRecord::Migration
  def change
    remove_column :locations, :timezone, :string
  end
end
