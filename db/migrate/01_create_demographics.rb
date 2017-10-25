class CreateDemographics < ActiveRecord::Migration
  def change
    create_table :demographics do |t|
      t.boolean :is_member
      t.integer :gender
      t.integer :min_age
      t.integer :max_age
    end
  end
end
