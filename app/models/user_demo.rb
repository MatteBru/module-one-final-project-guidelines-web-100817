class UserDemo < ActiveRecord::Base
  has_many :trips
  has_many :trip_stations, through: :trips
  has_many :stations, through: :trip_stations
  has_many :bikes, through: :trips
end
