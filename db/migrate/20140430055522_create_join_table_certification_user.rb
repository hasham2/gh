class CreateJoinTableCertificationUser < ActiveRecord::Migration
  def change
    create_join_table :Certifications, :Users,id: false do |t|
       t.index [:certification_id, :user_id]
       t.index [:user_id, :certification_id]
    end
  end
end
