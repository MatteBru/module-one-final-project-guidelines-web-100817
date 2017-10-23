class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :journey_id
      t.integer :user_demo_id
      t.integer :bicycle_id
      t.integer :trip_station_id
      t.integer :trip_duration
      t.datetime :start_time
      t.datetime :end_time
    end
  end
end
