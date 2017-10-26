require 'csv'
require 'pry'
require_all "config/default"
def fetch_info(url)
  begin
    info = JSON.parse(RestClient.get(url))
    return info
  rescue RestClient::Exceptions::OpenTimeout
    retry
  end

end

def loc_to_vals(locs ={sslat: nil, sslong: nil, eslat: nil, eslong: nil})
  url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{locs[:sslat]},#{locs[:sslong]}&destinations=#{locs[:eslat]},#{locs[:eslong]}&mode=bicycling&key=AIzaSyDs4U_6HGXQc00hEMTurM9tl8JNjRsB9LY"
  trip_hash = fetch_info(url)
  # binding.pry
  elements = trip_hash["rows"][0]["elements"][0]
  return {distance: nil, time: nil} if elements["status"] == "ZERO_RESULTS"
  val_arr = elements.first(2).map{|a| a[1].values_at("text")}.flatten
  g_hash = {distance: val_arr[0].to_f, time: (val_arr[1].to_i*60)}
end

i = 0
texisting = 0
tcreated = 0
hexisting = 0
hcreated = 0
existing = 0
created = 0
test_demo = 0

  CSV.foreach('lib/seeds/201709-citibike-tripdata.csv', headers: true) do |row|
      t = Trip.create

      t.bike = Bike.find_or_create_by(bicycle_id: row["bikeid"])

      rider_stats = {birth_year:row["birth year"], gender: row["gender"], is_member: row["usertype"] == "Subscriber"}

      # binding.pry if !row["birth year"] || row["gender"].to_i == 0
      t.rider_type = RiderType.find_or_create_by(rider_stats
        # is_member: rider_stats[:is_member],
        # gender: rider_stats[:gender],
        # birth_year: rider_stats[:birth_year]
      )
      rider_stats[:age] = t.rider_type.birth_year == 0 ? 0 :(2017 - t.rider_type.birth_year)

      t.demographic = Demographic.where('min_age <= ? AND max_age >= ? AND gender = ? AND is_member = ?', rider_stats[:age], rider_stats[:age], rider_stats[:gender], rider_stats[:is_member])[0]

      station_locs = {sslong: row["start station longitude"], sslat: row["start station latitude"], eslong: row["end station longitude"], eslat: row["end station latitude"]}

      ss = start_station = Station.find_or_create_by(
        stat_id: row["start station id"],
        station_name: row["start station name"],
        latitude: station_locs[:sslat],
        longitude: station_locs[:sslong])

      es = end_station = Station.find_or_create_by(
        stat_id: row["end station id"],
        station_name: row["end station name"],
        latitude: station_locs[:eslat],
        longitude: station_locs[:eslong])

      params = {start_station_id: ss.id, end_station_id: es.id}

      ts_arr = TripStation.where('start_station_id = ? AND end_station_id = ?', params[:start_station_id], params[:end_station_id])

      if ts_arr.empty?
        gmaps_hash = loc_to_vals(sslat:station_locs[:sslat], sslong:station_locs[:sslong], eslat:station_locs[:eslat], eslong:station_locs[:eslong])

        t.trip_station = TripStation.create(start_station: ss, end_station: es, est_time: gmaps_hash[:time], est_distance: gmaps_hash[:distance])

        created += 1
        tcreated += 1
        hcreated += 1
      else
        t.trip_station = ts_arr[0]
        existing += 1
        texisting += 1
        hexisting += 1
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
      test_demo +=1

      if i%100==0
        puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  #{i} trips saved  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        puts" #{i} created ... TripStations created: #{hcreated} - existing TripStations used: #{hexisting} "
        puts"@@@@@@@@@@@@  TOTALS --> created: #{created} @@@ existing: #{existing} <-- TOTALS  @@@@@@@@@@@@"
        puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        hexisting =0
        hcreated =0
        texisting =0
        tcreated =0
      elsif i % 10 == 0

        puts"saved No. #{i}: #{t.start_time} to #{t.end_time}"
        puts"TripStations created: #{tcreated} - existing TripStations used: #{texisting}"
        puts"-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
        texisting =0
        tcreated =0
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
