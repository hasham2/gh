class CreateCertificationsJobs < ActiveRecord::Migration
  def change
    create_table :certifications_jobs, id:false do |t|
      t.belongs_to :certification
      t.belongs_to :job
    end
  end
end
