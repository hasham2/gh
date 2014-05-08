class Job < ActiveRecord::Base
  belongs_to :user #Employer
  has_one :location, as: :locateable
  has_many :photos, as: :photoable

  has_and_belongs_to_many :certifications
  has_and_belongs_to_many :requirements
end
