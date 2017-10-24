require 'csv'
require 'pry'

def fetch_info(url)
  info = JSON.parse(RestClient.get(url))
end



def loc_to_vals(sslat:, sslong:, eslat:, eslong:)
  url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{sslat},#{sslong}&destinations=#{eslat},#{eslong}&mode=bicycling"
  trip_hash = fetch_info(url)

  val_arr = trip_hash["rows"][0]["elements"][0].first(2).map{|a| a[1].values_at("text")}.flatten

  val_arr = val_arr.map {|string| string.split.first}

  g_hash = {distance: val_arr[0].to_f, time: (val_arr[1].to_i*60)}
end

i = 0
existing = 0
created = 0
  CSV.foreach('lib/seeds/201709-citibike-tripdata.csv', headers: true) do |row|
    # binding.pry

      sslong = row["start station longitude"]
      sslat = row["start station latitude"]
      eslong = row["end station longitude"]
      eslat = row["end station latitude"]
      t = Trip.create
      # binding.pry
      # t.demographic_id =
      t.bike = Bike.find_or_create_by(bicycle_id: row["bikeid"])
      # binding.pry


      ss = start_station = Station.find_or_create_by(
        stat_id: row["start station id"],
        station_name: row["start station name"],
        latitude: sslat,
        longitude: sslong)

      es = end_station = Station.find_or_create_by(
        stat_id: row["end station id"],
        station_name: row["end station name"],
        latitude: eslat,
        longitude: eslong)

      params = {start_station_id: ss.id, end_station_id: es.id}

      ts_arr = TripStation.where('start_station_id = ? AND end_station_id = ?', params[:start_station_id], params[:end_station_id])

      if ts_arr.empty?
        gmaps_hash = loc_to_vals(sslat:sslat, sslong:sslong, eslat:eslat, eslong:eslong)

        t.trip_station = TripStation.create(start_station: ss, end_station: es, est_time: gmaps_hash[:time], est_distance: gmaps_hash[:distance])

        created += 1
      else
        t.trip_station = ts_arr[0]
        existing += 1
      end

      # binding.pry

      t.trip_duration = row["tripduration"]

      t.start_time = DateTime.strptime("#{row["starttime"]}", "%m/%d/%y %H:%M")

      t.end_time = DateTime.strptime("#{row["stoptime"]}", "%m/%d/%y %H:%M")

      # gmaps_hash = loc_to_vals(sslat:sslat, sslong:sslong, eslat:eslat, eslong:eslong)
      # #
      # t.est_distance = gmaps_hash[:distance]
      # t.est_time = gmaps_hash[:time]
      # binding.pry


      t.save
      i += 1

      if i%100==0
        puts "#{i} trips saved"
        puts"#{i} created ... TripStations created: #{created} - existing TripStations used: #{existing}"
        puts"-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
      elsif i % 10 == 0
        puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        puts"saved No. #{i}: #{t.start_time} to #{t.end_time}"
        puts"TripStations created: #{created} - existing TripStations used: #{existing}"
        puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
      end
    # end
  end

# end





# Station.create(station_name:"Helpme St", stat_id: 1234)
# Station.create(station_name:"my mind is jello Ave", stat_id: 5678)
# Station.create(station_name:"Ouch Blvd", stat_id: 1234)
# Station.create(station_name:"Wall St", stat_id: 1234)
#
#
# Trip.create(trip_station_id: TripStation.find_or_create_by(start_station: Station.first, end_station: Station.last).id)
