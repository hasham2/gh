class AddEmployerIdToCertification < ActiveRecord::Migration
  def change
    add_column :certifications, :employer_id, :integer
  end
end
