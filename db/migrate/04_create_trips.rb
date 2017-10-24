class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.integer :demographic_id
      t.integer :bike_id
      t.integer :trip_duration
      t.datetime :start_time
      t.datetime :end_time
      t.float :est_distance
      # In Miles! ^^^^^^^^^^^^^^^^
      t.integer :est_time
      # In Seconds! ^^^^^^^^^^^^^^
    end
  end
end
