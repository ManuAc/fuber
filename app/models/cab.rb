class Cab < ActiveRecord::Base

  scope :available, lambda { where(active: true, available: true) }

  belongs_to :driver
  has_one :current_location, as: :source, class_name: 'Location'

  def mark_available(location)
    self.available = true
    self.current_location.update_attributes(latitude: location.latitude, longitude: location.longitude)
    self.save
  end

  def mark_unavailable
    update_attributes(available: false)
  end

  def self.list_cabs(city, location)
    minimum_distance = Location::MAXIMUM_RADIUS
    cabs = []

    Cab.where(city: city).available.each do |cab|
      distance = Location.get_distance(location, cab.current_location)
      if distance <= minimum_distance
        cabs << cab
      end
    end
    cabs
  end

  def self.book_cab(user, city, location, ctype = nil)
    available_cabs = if ctype.present?
      Cab.where(city: city, ctype: ctype).available
    else
      Cab.where(city: city).available
    end

    minimum_distance = Location::MAXIMUM_RADIUS
    nearest_cab = nil

    available_cabs.each do |cab|
      distance = Location.get_distance(location, cab.current_location)
      if distance <= minimum_distance
        minimum_distance = distance
        nearest_cab = cab
      end
    end

    if nearest_cab.present?
      Trip.create_trip(user, nearest_cab)
    end
  end
end
