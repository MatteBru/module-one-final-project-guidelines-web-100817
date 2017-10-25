class Station < ActiveRecord::Base

  has_many :trip_stations_from, :class_name => 'TripStation', :foreign_key => 'start_station_id'
  has_many :trip_stations_to, :class_name => 'TripStation', :foreign_key => 'end_station_id'


  has_many :trips_from, through: :trip_stations_from, :source => :trips
  has_many :trips_to, through: :trip_stations_to, :source => :trips



  has_many :bikes_to, through: :trips_to, :source => :bike
  has_many :bikes_from, through: :trips_from, :source => :bike

  has_many :rider_types_to, through: :trips_to, :source => :rider_type
  has_many :rider_types_from, through: :trips_from, :source => :rider_type


  def trips
    self.trips_to + self.trips_from
  end

  def bikes
      self.bikes_from + self.bikes_to
  end

  def self.busiest
    station_hash = {}
    self.all.each do |station|
      station_hash[station.station_name] = station.trips.count
    end
    Hash[station_hash.sort_by{|s, t| t}.reverse.first(10)]
  end

end
