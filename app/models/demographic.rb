class Demographic < ActiveRecord::Base
  has_many :rider_types
  has_many :trips, through: :rider_types
  has_many :bikes, through: :rider_types
  has_many :trip_stations, through: :trips
  has_many :start_stations, through: :trip_stations
  has_many :end_stations, through: :trip_stations

end
