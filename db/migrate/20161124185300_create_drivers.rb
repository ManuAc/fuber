class CreateDrivers < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :email, index: true, unique: true
      t.string :mobile
      t.text :adress

      t.timestamps null: false
    end
  end
end
