class Location < ActiveRecord::Base
  validates :city, presence: true
  belongs_to :user
end
