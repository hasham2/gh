class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :certifications, :users do |t|
	      t.index [:certification_id, :user_id]
	      t.index [:user_id, :certification_id]
    end
  end
end
