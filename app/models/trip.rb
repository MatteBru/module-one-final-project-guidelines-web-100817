class Trip < ActiveRecord::Base
  belongs_to :rider_type
  belongs_to :trip_station
  belongs_to :bike

  has_one :start_station, through: :trip_station
  has_one :end_station, through: :trip_station

  has_one :demographic, through: :rider_type
end
