class Location < ActiveRecord::Base

  # validates :city, presence: true
  belongs_to :locateable, polymorphic: true
  # validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)

  
  # validates :address, presence: true
  # validates :city, presence: true
  # validates :state, presence: true
  # validates :zip, presence: true
  # validates :country, presence: true
  
  geocoded_by :full_address, latitude: :lat, longitude: :lng
  after_validation :geocode
  
  def full_address
    ##convert address to geocoded values
    "#{self.address}, #{self.city}, #{self.zip}, #{self.state}, #{self.country}"
  end

end
