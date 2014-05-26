class CreateCertificationsUsers < ActiveRecord::Migration
  def change
    create_table :certifications_users, id: false do |t|
    	t.belongs_to :certification
    	t.belongs_to :user
    end
  end
end
