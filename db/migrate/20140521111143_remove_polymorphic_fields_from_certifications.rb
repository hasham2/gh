class RemovePolymorphicFieldsFromCertifications < ActiveRecord::Migration
  def change
    remove_column :certifications, :certificable_id
    remove_column :certifications, :certificable_type
  end
end
