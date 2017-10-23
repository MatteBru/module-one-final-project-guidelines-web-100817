Station.create(station_name:"Helpme St", stat_id: 1234)
Station.create(station_name:"my mind is jello Ave", stat_id: 5678)
Station.create(station_name:"Ouch Blvd", stat_id: 1234)
Station.create(station_name:"Wall St", stat_id: 1234)


Trip.create(trip_station_id: TripStation.find_or_create_by(start_station: Station.first, end_station: Station.last).id)
