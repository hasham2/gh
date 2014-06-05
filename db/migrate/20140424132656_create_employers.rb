class CreateEmployers < ActiveRecord::Migration
  def change
    create_table :employers do |t|
      t.belongs_to :user
      t.string :business_name
      t.string :industry
      t.string :phone
      t.string :website
      t.string :other_industry
      t.timestamps
    end
  end
end
