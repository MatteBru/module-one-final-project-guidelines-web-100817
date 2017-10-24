class Station < ActiveRecord::Base
  has_many :tripstations_from, :class_name => 'TripStation', :foreign_key => 'start_station_id'

  has_many :tripstations_to, :class_name => 'TripStation', :foreign_key => 'end_station_id'


  has_many :trips_from, through: :tripstations_from, :source => :trips

  has_many :trips_to, through: :tripstations_to, :source => :trips

  # has_many :bikes, through: :trips

  def trips
    self.trips_to + self.trips_from
  end

  def bikes
      self.trips.map{|trip| trip.bike}
  end

  def self.busiest
    station_hash = {}
    self.all.each do |station|
      station_hash[station.station_name] = station.trips.count
    end
    Hash[station_hash.sort_by{|s, t| t}.reverse.first(10)]
  end

end
