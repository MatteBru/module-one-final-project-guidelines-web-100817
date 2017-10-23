class Station < ActiveRecord::Base
  has_many :trip_stations_as_start_station, :class_name => 'TripStation', :foreign_key => 'start_station_id'

  has_many :trip_stations_as_end_station, :class_name => 'TripStation', :foreign_key => 'end_station_id'


  has_many :trips, through: :trip_stations
  has_many :bikes, through: :trips
end
