class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.decimal :latitude, precision: 5, scale: 2
      t.decimal :longitude, precision: 5, scale: 2

      t.timestamps null: false
    end
  end
end
