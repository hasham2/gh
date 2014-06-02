class RemoveJoinTableCertificationsJobs < ActiveRecord::Migration
  def change
  	drop_table :certifications_jobs
  end
end
