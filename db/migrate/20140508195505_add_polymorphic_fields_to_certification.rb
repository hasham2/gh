class AddPolymorphicFieldsToCertification < ActiveRecord::Migration
  def change
  	add_column :certifications, :certificable_id, :integer
  	add_column :certifications, :certificable_type, :string
  end
end
