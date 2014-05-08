class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.belongs_to :user
      t.string    :title
      t.integer   :hours_per_day
      t.integer   :work_duration
      t.float     :desired_wage
      t.float     :max_wage
      t.boolean   :desired_wage_is_firm, default: false
      t.date      :start_date
      t.datetime  :listing_expires_on
      t.text      :description
      t.timestamps
    end
  end
end
