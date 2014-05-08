class CreateWorkHours < ActiveRecord::Migration
  def change
    create_table :work_hours do |t|
      t.string :day_of_week
      t.time :start_time
      t.time :end_time
      t.integer :user_id
      t.timestamps
    end
  end
end
