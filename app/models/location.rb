class Location < ActiveRecord::Base
  # Distance in KMs
  MAXIMUM_RADIUS = 25

  belongs_to :source, polymorphic: true

  def self.get_distance(location1, location2)
    radius = 6371
    lat1 = to_rad(location1.latitude)
    lat2 = to_rad(location2.latitude)

    lon1 = to_rad(location1.longitude)
    lon2 = to_rad(location2.longitude)

    dLat = lat2-lat1   
    dLon = lon2-lon1

    a = Math::sin(dLat/2) * Math::sin(dLat/2) +
         Math::cos(lat1) * Math::cos(lat2) * 
         Math::sin(dLon/2) * Math::sin(dLon/2)

    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    (radius * c).round(2)
  end

  def self.to_rad angle
    (angle/180) * Math::PI
  end
end
