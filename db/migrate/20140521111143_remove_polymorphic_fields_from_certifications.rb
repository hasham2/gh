class RemovePolimorphicFieldsFromCertifications < ActiveRecord::Migration
  def change
    remove_column :certifications, :certificable_id, :integer
    remove_column :certifications, :certificable_type, :string
  end
end
