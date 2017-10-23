class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :stat_id
      t.string :station_name
      t.float :latitude
      t.float :longitude
    end
  end
end
