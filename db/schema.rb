# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161126225521) do

  create_table "cabs", force: :cascade do |t|
    t.string   "name"
    t.string   "model"
    t.string   "number"
    t.string   "ctype"
    t.string   "city"
    t.integer  "driver_id"
    t.boolean  "active"
    t.boolean  "available"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "cabs", ["ctype"], name: "index_cabs_on_ctype"
  add_index "cabs", ["driver_id"], name: "index_cabs_on_driver_id"
  add_index "cabs", ["number"], name: "index_cabs_on_number"

  create_table "drivers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.text     "adress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "drivers", ["email"], name: "index_drivers_on_email"

  create_table "locations", force: :cascade do |t|
    t.decimal  "latitude",    precision: 5, scale: 2
    t.decimal  "longitude",   precision: 5, scale: 2
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "source_id"
    t.string   "source_type"
  end

  create_table "trips", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "cab_id"
    t.string   "start_location_id"
    t.string   "end_location_id"
    t.decimal  "fare",              precision: 10, scale: 2
    t.integer  "status"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.datetime "started_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "mobile"
    t.string   "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email"

end
