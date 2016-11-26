class CreateCabs < ActiveRecord::Migration
  def change
    create_table :cabs do |t|
      t.string :name
      t.string :model
      t.string :number, index: true
      t.string :ctype, index: true
      t.string :city
      t.belongs_to :driver, index: true, unique: true, foreign_key: true
      t.boolean :active, default: false
      t.boolean :available, default: true

      t.timestamps null: false
    end
  end
end
