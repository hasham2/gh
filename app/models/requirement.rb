class Requirement < ActiveRecord::Base
  has_and_belongs_to_many :jobs
end
