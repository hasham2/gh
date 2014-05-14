class Job < ActiveRecord::Base
  belongs_to :user #Employer
  has_one :location, as: :locateable
  has_many :photos, as: :photoable

  has_many :certifications, as: :certificable
  has_and_belongs_to_many :requirements
  has_and_belongs_to_many :metrics
end
