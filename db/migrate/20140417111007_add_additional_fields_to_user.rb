class AddAdditionalFieldsToUser < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      t.string :company_phone
      t.string :company_website
    end
  end
end
