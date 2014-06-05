class ChangeDataTypeOfCreditScore < ActiveRecord::Migration
  def change
  	change_column :users, :credit_score, :string
  end
end
