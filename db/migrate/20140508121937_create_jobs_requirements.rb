class CreateJobsRequirements < ActiveRecord::Migration
  def change
    create_table :jobs_requirements, id: false do |t|
      t.references :job, :requirement
    end
    add_index :jobs_requirements, [:job_id, :requirement_id]
  end
end
