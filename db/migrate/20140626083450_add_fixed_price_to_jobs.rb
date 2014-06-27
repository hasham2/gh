class AddFixedPriceToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :fixed_price, :string
  end
end
