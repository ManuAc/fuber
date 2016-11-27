class Trip < ActiveRecord::Base
  enum status: [
    :booked,
    :started,
    :ended,
    :cancelled
  ]

  belongs_to :user
  belongs_to :cab
  belongs_to :start_location, class_name: 'Location'
  belongs_to :end_location, class_name: 'Location'

  validates_presence_of :user, :cab

  def start(location)
    self.status = :started
    self.started_at = Time.now
    self.start_location = location
    self.save
  end

  def end(location)
    ActiveRecord::Base.transaction do
      self.end_location = location
      self.fare = calculate_fare
      self.status = :ended
      self.cab.mark_available(location)
      self.save
    end
  end

  def calculate_fare
    amount = 0
    start_time = self.started_at
    end_time = Time.now

    # Charge for time
    total_time_in_min = (end_time - start_time)/60
    amount += total_time_in_min

    # Charge for distance
    distance = Location.get_distance(start_location, end_location)
    amount = distance * 2

    # Extra charge if the car type is 'pink'
    if self.cab.ctype == 'pink'
      amount += 5
    end
    amount
  end

  def self.create_trip(user, cab)
    ActiveRecord::Base.transaction do
      trip = Trip.new
      trip.user = user
      trip.cab = cab
      trip.status = :booked
      if trip.save
        cab.mark_unavailable
        trip
      end
    end
  end
end
