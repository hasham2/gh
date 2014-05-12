class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.references :metric_type
      t.integer :value
      t.timestamps
    end
  end
end
