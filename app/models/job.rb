class Job < ActiveRecord::Base
  belongs_to :user #Employer

  has_and_belongs_to_many :certifications
  accepts_nested_attributes_for :certifications

  has_and_belongs_to_many :requirements
  accepts_nested_attributes_for :requirements

  has_and_belongs_to_many :metrics
  accepts_nested_attributes_for :metrics

  has_many :photos, as: :photoable
  accepts_nested_attributes_for :photos

  has_one :location, as: :locateable
  accepts_nested_attributes_for :location

end
