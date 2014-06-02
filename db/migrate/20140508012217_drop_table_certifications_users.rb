class DropTableCertificationsUsers < ActiveRecord::Migration
  def change
  	drop_table :certifications_users
  end
end
