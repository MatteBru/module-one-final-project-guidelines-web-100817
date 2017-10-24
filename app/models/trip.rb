class Trip < ActiveRecord::Base
  belongs_to :trip_station
  has_one :start_station, through: :trip_station
  has_one :end_station, through: :trip_station
  belongs_to :bike
  belongs_to :demographic
end
