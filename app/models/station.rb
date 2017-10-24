class Station < ActiveRecord::Base
  has_many :tripstation_from, :class_name => 'TripStation', :foreign_key => 'start_station_id'

  has_many :tripstation_to, :class_name => 'TripStation', :foreign_key => 'end_station_id'


  has_many :trips_from, through: :tripstation_from, :foreign_key => "trip_id"

  has_many :trips_to, through: :tripstation_to, :foreign_key => "trip_id"

  has_many :bikes, through: :trips
end
