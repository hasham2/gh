class AddJobLevelToJob < ActiveRecord::Migration
  def change
    add_column :jobs, :job_level, :string
  end
end
