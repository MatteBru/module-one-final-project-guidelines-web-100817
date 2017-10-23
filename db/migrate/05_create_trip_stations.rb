class CreateTripStations < ActiveRecord::Migration
  def change
    create_table :trip_stations do |t|
      t.integer :journey_id
      t.integer :start_station_id
      t.integer :end_station_id
    end
  end
end
