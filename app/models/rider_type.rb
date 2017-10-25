class RiderType < ActiveRecord::Base
  belongs_to :demographic
  has_many :trips
  has_many :trip_stations, through: :trips
  has_many :start_stations, through: :trip_stations
  has_many :end_stations, through: :trip_stations
  has_many :bikes, through: :trips
end
