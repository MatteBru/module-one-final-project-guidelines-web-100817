class CreateTripStations < ActiveRecord::Migration
  def change
    create_table :trip_stations do |t|
      t.integer :trip_id
      t.references :start_station
      t.references :end_station
    end
  end
end
