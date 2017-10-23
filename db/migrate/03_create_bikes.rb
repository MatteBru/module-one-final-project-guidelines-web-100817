class CreateBikes < ActiveRecord::Migration
  def change
    create_table :bikes do |t|
      t.integer :bicycle_id primary_key true:
    end
  end
end
