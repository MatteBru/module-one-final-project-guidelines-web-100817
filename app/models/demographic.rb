class Demographic < ActiveRecord::Base
  has_many :rider_types
  has_many :trips, through: :rider_types
  has_many :trip_stations, through: :trips
  has_many :stations, through: :trip_stations
  has_many :bikes, through: :rider_types
end
