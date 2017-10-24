require 'csv'
require 'pry'

# csv_text = File.read('lib/seeds/201709-citibike-tripdata.csv')
# csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')


# until i == 0 do
  CSV.foreach('lib/seeds/60_sample.csv', headers: true) do |row|
    # binding.pry
    # until i == 0 do
      t = Trip.create
      # binding.pry
      # t.demographic_id =
      t.bike = Bike.find_or_create_by(bicycle_id: row["bikeid"])
      # binding.pry


      t.start_station = Station.find_or_create_by(
        stat_id: row["start station id"],
        station_name: row["start station name"],
        latitude: row["start station latitude"],
        longitude: row["start station longitude"])

      t.end_station = Station.find_or_create_by(
        stat_id: row["end station id"],
        station_name: row["end station name"],
        latitude: row["end station latitude"],
        longitude: row["end station longitude"])

      t.trip_station.trip_id = t.id
      t.trip_station.save

      # ts = TripStation.create(trip_id: t.id,
      #   start_station: ss,
      #   end_station: es)

      # binding.pry


      t.trip_duration = row["tripduration"]

      t.start_time = DateTime.strptime("#{row["starttime"]}", "%m/%d/%y %H:%M")
      t.end_time = DateTime.strptime("#{row["stoptime"]}", "%m/%d/%y %H:%M")
      t.save

      puts"saved #{t.start_time} to #{t.end_time}"
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
