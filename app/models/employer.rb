class Employer < ActiveRecord::Base
  belongs_to :user
  acts_as_taggable 
  acts_as_taggable_on :business_activity
end
