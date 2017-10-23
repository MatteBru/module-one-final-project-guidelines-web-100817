class Station < ActiveRecord::Base
  has_many :trip_stations
  has_many :trips, through: :trip_stations
  has_many :bikes, through: :trips
end
