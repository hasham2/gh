class Metric < ActiveRecord::Base
  has_and_belongs_to_many :jobs
  belongs_to :metric_type
  accepts_nested_attributes_for :metric_type

end
