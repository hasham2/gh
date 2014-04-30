class Location < ActiveRecord::Base
  # validates :city, presence: true

  belongs_to :locateable, polymorphic: true
  # validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)
end
