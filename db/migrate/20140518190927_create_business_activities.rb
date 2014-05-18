class CreateBusinessActivities < ActiveRecord::Migration
  def change
    create_table :business_activities do |t|
      t.string :keyword

      t.timestamps
    end
  end
end
