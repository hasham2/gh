class Job < ActiveRecord::Base
  belongs_to :user #Employer

  has_many :certifications, as: :certificable
  has_and_belongs_to_many :requirements
  
  has_and_belongs_to_many :metrics
  accepts_nested_attributes_for :metrics

  has_many :photos, as: :photoable
  accepts_nested_attributes_for :photos

  has_one :location, as: :locateable
  accepts_nested_attributes_for :location


end
