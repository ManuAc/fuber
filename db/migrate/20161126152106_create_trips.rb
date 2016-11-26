class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.belongs_to :user
      t.belongs_to :cab
      t.string :start_location_id
      t.string :end_location_id
      t.decimal :fare, precision: 10, scale: 2
      t.integer :status
      t.timestamp :started_at

      t.timestamps null: false
    end
  end
end
