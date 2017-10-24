class TripStation < ActiveRecord::Base
  has_many :trips
  belongs_to :start_station, :class_name => 'Station'
  belongs_to :end_station, :class_name => 'Station'
end
