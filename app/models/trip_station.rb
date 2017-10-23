class TripStation < ActiveRecord::Base
  belongs_to :trip
  belongs_to :start_station, :class_name => 'Station'
  belongs_to :end_station, :class_name => 'Station'
end
