class Location < ActiveRecord::Base
  validates :city, presence: true
end
