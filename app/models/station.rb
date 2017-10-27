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
      estat = Hash.new 0
      self.all.each do |es|
        estat[es.station_name] = es.trips.count
      end
      Hash[estat.sort_by{|s, t| t}.reverse.first(10)]
  end

  def self.printer(hash)
    s =""
    hash.each do |k,v|
      s << "#{k} ----> #{v}\n"
    end
    s
  end

  def self.busy_string
    "\nOur data shows #{self.count} stations, with #{TripStation.count} unique combinations between them.\nThe theoretical posssible number combinations of these stations is #{self.count**2}.\nThe most frequently used stations are:\n#{printer(self.busiest)}"
  end

end
