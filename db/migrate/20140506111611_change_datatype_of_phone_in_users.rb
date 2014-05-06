class ChangeDatatypeOfPhoneInUsers < ActiveRecord::Migration
  def up
  	change_column :users, :phone_primary,  'text USING CAST(phone_primary AS text)' 
  	change_column :users, :phone_secondary,  'text USING CAST(phone_secondary AS text)' 
  end
  def down
  	change_column :users, :phone_primary,  'text USING CAST(phone_primary AS text)' 
  	change_column :users, :phone_secondary,  'text USING CAST(phone_secondary AS text)' 
  end
end
