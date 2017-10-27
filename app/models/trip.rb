class Trip < ActiveRecord::Base
  belongs_to :rider_type
  belongs_to :trip_station
  belongs_to :bike

  has_one :start_station, through: :trip_station
  has_one :end_station, through: :trip_station

  has_one :demographic, through: :rider_type

  def self.trip_info
    "Our dataset includes #{self.count} trips from the month of September, resulting in  with the longest being from #{Station.find(488).station_name} to #{Station.find(142).station_name}, with a distance of #{TripStation.find(81801).est_distance} covered in 1.15 hours, resulting in an estimated speed of 11.73 MPH."

  end
end
