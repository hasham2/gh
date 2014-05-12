class CreateJobMetrics < ActiveRecord::Migration
  def change
    create_table :jobs_metrics, id: false do |t|
      t.references :job, :metric
    end
    add_index :jobs_metrics, [:job_id, :metric_id]
  end
end
