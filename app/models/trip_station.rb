class TripStation < ActiveRecord::Base
  has_many :stations
  belongs_to :trip
end
