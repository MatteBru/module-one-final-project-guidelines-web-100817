class CreateUserDemos < ActiveRecord::Migration
  def change
    create_table :user_demos do |t|
      t.boolean :is_member
      t.text :gender
      t.integer :min_age
      t.integer :max_age
    end
  end
end
