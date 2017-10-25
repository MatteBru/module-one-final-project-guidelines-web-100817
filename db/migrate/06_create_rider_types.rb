class CreateRiderTypes < ActiveRecord::Migration
  def change
    create_table :rider_types do |t|
      t.integer :demographic_id
      t.boolean :is_member
      t.integer :gender
      t.integer :birth_year
    end
  end
end
