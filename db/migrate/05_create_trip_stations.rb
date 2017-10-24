class CreateTripStations < ActiveRecord::Migration
  def change
    create_table :trip_stations do |t|
      # t.integer :trip_id
      t.references :start_station
      t.references :end_station
      t.float :est_distance
      # In Miles! ^^^^^^^^^^^^^^^^
      t.integer :est_time
      # In Seconds! ^^^^^^^^^^^^^^
    end
  end
end

# TripStation.find(:first, :conditions => [ "start_station_id = ? AND end_station_id = ?", ])
#
# TripStation.where('start_station_id = ? AND end_station_id = ?', params[:start_station_id], params[:end_station_id])
