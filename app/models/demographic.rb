class Demographic < ActiveRecord::Base
  has_many :rider_types
  has_many :trips, through: :rider_types
  has_many :bikes, through: :rider_types
  has_many :trip_stations, through: :trips
  has_many :start_stations, through: :trip_stations
  has_many :end_stations, through: :trip_stations

  def sex
    if self.gender == 1
      "Female"
    elsif self.gender == 2
      "Male"
    else
      "Unknown gender"
    end
  end

  def time_traveled
    (self.trips.sum(:trip_duration)/60/60.0).round(2)
  end

  def distance_traveled
    self.trip_stations.sum(:est_distance).round(2)
  end

  def est_time
    (self.trip_stations.sum(:est_time)/60/60.0).round(2)
  end

  def most_left
    sstat = Hash.new 0
    self.start_stations.each do |ss|
      sstat[ss.station_name] += 1
    end
    Hash[sstat.sort_by{|s, t| t}.reverse.first(10)]
  end

  def most_arrived
    estat = Hash.new 0
    self.end_stations.each do |es|
      estat[es.station_name] += 1
    end
    Hash[estat.sort_by{|s, t| t}.reverse.first(10)]
  end

  def unique_routes
    self.trip_stations.uniq.count
  end

  def unique_stations
    (self.start_stations.uniq + self.end_stations.uniq).uniq.count
  end

  def printer(hash)
    s =""
    hash.each do |k,v|
      s << "#{k} ----> #{v}\n"
    end
    s
  end




  def trip_summary
    "\n#{self.trips.count} trips taken by #{self.sex} riders between #{self.min_age} and #{self.max_age} years old:\n\nTotaling approximately #{self.distance_traveled} miles traveled over #{self.time_traveled} hours \nexceeding Google's predicted time of #{self.est_time.round(2)} hours by #{(self.time_traveled-self.est_time).round(2)} hours\naveraging a speed of #{(self.distance_traveled/self.time_traveled).round(2)} MPH\n\n\n#{unique_routes} unique routes taken by #{self.sex} riders between #{self.min_age} and #{self.max_age} years old:\nbetween #{self.unique_stations} unique stations with the most frequently used being\n\nDEPARTURES:\n#{printer(self.most_left)}\n\nARRIVALSs:\n#{printer(self.most_arrived)}"
  end

end
