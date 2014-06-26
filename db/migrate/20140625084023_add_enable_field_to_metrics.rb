class AddEnableFieldToMetrics < ActiveRecord::Migration
  def change
    add_column :metrics, :enable, :boolean
  end
end
