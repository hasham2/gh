class ChangeDataTypeOfColumnInMetric < ActiveRecord::Migration
  def self.up
     change_table :metrics do |t|
       t.change :value, :float
     end
   end
   def self.down
     change_table :metrics do |t|
       t.change :value, :integer
     end
   end
end
