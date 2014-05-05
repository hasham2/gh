class RemoveSkillsetFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :skillset, :string
  end
end
