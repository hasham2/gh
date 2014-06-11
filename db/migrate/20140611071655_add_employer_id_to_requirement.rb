class AddEmployerIdToRequirement < ActiveRecord::Migration
  def change
    add_column :requirements, :employer_id, :integer
  end
end
