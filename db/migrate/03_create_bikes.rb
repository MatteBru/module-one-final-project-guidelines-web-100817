class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.integer :bicycle_id
    end
  end
end
