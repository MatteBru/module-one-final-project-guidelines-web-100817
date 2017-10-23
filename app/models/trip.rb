class Trip < ActiveRecord::Base
  belongs_to :trip_station
  has_many :stations, through: :trip_station
  belongs_to :bike
  belongs_to :user_demo
end
