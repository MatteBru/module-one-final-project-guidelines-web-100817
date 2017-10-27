class Bike < ActiveRecord::Base
  has_many :trips
  has_many :trip_stations, through: :trips
  has_many :stations, through: :trip_stations

  # def self.longest_dist
  #     estat = Hash.new 0
  #     self.all.each do |es|
  #       estat[es.bicycle_id] = es.trip_stations.inject(0){|sum,ts| (ts.est_distance? (sum + ts.est_distance) : 0)  }
  #     end
  #     Hash[estat.sort_by{|s, t| t}.reverse.first(10)]
  # end
  def self.busiest
      estat = Hash.new 0
      self.all.each do |es|
        estat[es.bicycle_id] = es.trip_stations.count
      end
      Hash[estat.sort_by{|s, t| t}.reverse.first(10)]
  end

  def self.bike_fun
    "Our data contains information on 10,405 individual bikes, making #{Trip.count} trips. They had an average speed of 7.75 MPH. \nThe busiest bikes were:\n id 30453 --> 115, \n id 30458 --> 111, \n id 30720 --> 108, \n id 30484 --> 107, \n id 30605 --> 104, \n id 29973 --> 102, \n id 30695 --> 102, \n id 30638 --> 99, \n id 30790 --> 99, \n id 30721 --> 98}"
  end

end
