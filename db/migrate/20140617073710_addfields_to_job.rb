class AddfieldsToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :views, :integer, :default => 0
    add_column :jobs, :active_job, :boolean, :default => false
  end
end
