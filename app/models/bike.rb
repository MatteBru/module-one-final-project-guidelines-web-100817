class Bike < ActiveRecord::Base
  has_many :trips
  has_many :trip_stations, through: :trips
  has_many :stations, through: :trip_stations
end
