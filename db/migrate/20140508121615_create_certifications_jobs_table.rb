class CreateCertificationsJobsTable < ActiveRecord::Migration
  def change
    create_table :certifications_jobs, id: false do |t|
      t.references :certification, :job
    end
    add_index :certifications_jobs, [:certification_id, :job_id]
  end
end
