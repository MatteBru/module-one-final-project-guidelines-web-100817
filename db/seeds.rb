require 'csv'
require 'pry'

def fetch_info(url)
  info = JSON.parse(RestClient.get(url))
end



def loc_to_vals(locs ={sslat: nil, sslong: nil, eslat: nil, eslong: nil})
  url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=#{locs[:sslat]},#{locs[:sslong]}&destinations=#{locs[:eslat]},#{locs[:eslong]}&mode=bicycling&key=AIzaSyDs4U_6HGXQc00hEMTurM9tl8JNjRsB9LY"
  trip_hash = fetch_info(url)
  # binding.pry
  elements = trip_hash["rows"][0]["elements"][0]
  return {distance: nil, time: nil} if elements["status"] == "ZERO_RESULTS"

  val_arr = elements.first(2).map{|a| a[1].values_at("text")}.flatten

  # val_arr = val_arr.map {|string| string.split.first}

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

#def Demographic variables
Demographic.create(min_age: 0,max_age: 25,gender: 1, is_member:true)
Demographic.create(min_age: 26,max_age: 50,gender: 1, is_member:true)
Demographic.create(min_age: 51,max_age: 60,gender: 1, is_member:true)
Demographic.create(min_age: 61,max_age: 100,gender: 1, is_member:true)
Demographic.create(min_age: 0,max_age: 25,gender: 2, is_member:true)
Demographic.create(min_age: 26,max_age: 50,gender: 2, is_member:true)
Demographic.create(min_age: 51,max_age: 60,gender: 2, is_member:true)
Demographic.create(min_age: 61,max_age: 100,gender: 2, is_member:true)
Demographic.create(min_age: 0,max_age: 25,gender: 1, is_member:false)
Demographic.create(min_age: 26,max_age: 50,gender: 1, is_member:false)
Demographic.create(min_age: 51,max_age: 60,gender: 1, is_member:false)
Demographic.create(min_age: 61,max_age: 100,gender: 1, is_member:false)
Demographic.create(min_age: 0,max_age: 25,gender: 2, is_member:false)
Demographic.create(min_age: 26,max_age: 50,gender: 2, is_member:false)
Demographic.create(min_age: 51,max_age: 60,gender: 2, is_member:false)
Demographic.create(min_age: 61,max_age: 100,gender: 2, is_member:false)
Demographic.create(min_age: 0,max_age: 25,gender: 0, is_member:true)
Demographic.create(min_age: 26,max_age: 50,gender: 0, is_member:true)
Demographic.create(min_age: 51,max_age: 60,gender: 0, is_member:true)
Demographic.create(min_age: 61,max_age: 100,gender: 0, is_member:true)
Demographic.create(min_age: 0,max_age: 25,gender: 0, is_member:false)
Demographic.create(min_age: 26,max_age: 50,gender: 0, is_member:false)
Demographic.create(min_age: 51,max_age: 60,gender: 0, is_member:false)
Demographic.create(min_age: 61,max_age: 100,gender: 0, is_member:false)




  CSV.foreach('lib/seeds/60_sample.csv', headers: true) do |row|
    # binding.pry

      sslong = row["start station longitude"]
      sslat = row["start station latitude"]
      eslong = row["end station longitude"]
      eslat = row["end station latitude"]
      t = Trip.create
      #binding.pry
      # t.demographic_id =
      t.bike = Bike.find_or_create_by(bicycle_id: row["bikeid"])
      # binding.pry
      t.rider_type = RiderType.find_or_create_by(
        # usertype,birth year,gender
        is_member: row["usertype"] == "Subscriber",
        gender: row["gender"],
        birth_year: row["birth year"])

      # t.demographic = Demographic.find_or_create_by(
      #   min_age: 18,
      #   max_age: 70,
      #   gender: row["gender"],
      #   is_member: row["usertype"] == "Subscriber")

        rider_stats = {age: (2017 - t.rider_type.birth_year), gender: t.rider_type.gender, is_member: t.rider_type.is_member}

        # binding.pry

      t.demographic = Demographic.where('min_age <= ? AND max_age >= ? AND gender = ? AND is_member = ?', rider_stats[:age], rider_stats[:age], rider_stats[:gender], rider_stats[:is_member])[0]



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
        puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        puts "#{i} trips saved"
        puts"#{i} created ... TripStations created: #{hcreated} - existing TripStations used: #{hexisting}"
        puts"||||||TOTALS --> created: #{created} ||| existing: #{existing} <-- TOTALS||||||"
        puts"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
        hexisting =0
        hcreated =0
        texisting =0
        tcreated =0
      elsif i % 10 == 0

        puts"saved No. #{i}: #{t.start_time} to #{t.end_time}"
        puts"TripStations created: #{tcreated} - existing TripStations used: #{texisting}"
        puts"-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*"
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
