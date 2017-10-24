class Trip < ActiveRecord::Base
  has_one :trip_station
  has_one :start_station, through: :trip_station
  has_one :end_station, through: :trip_station
  belongs_to :bike
  belongs_to :demographic
end
