# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_14_122214) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "routes", primary_key: "route_id", id: :string, force: :cascade do |t|
    t.string "short_name"
    t.string "long_name"
    t.integer "route_type"
    t.string "color"
    t.string "text_color"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stop_times", force: :cascade do |t|
    t.string "trip_id"
    t.string "arrival_time", null: false
    t.string "departure_time", null: false
    t.string "stop_id", null: false
    t.integer "stop_sequence", null: false
    t.string "stop_headsign"
    t.string "pickup_type"
    t.string "drop_off_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "stops", primary_key: "stop_id", id: :string, force: :cascade do |t|
    t.string "name"
    t.float "lat"
    t.float "lon"
    t.string "location_type"
    t.string "parent_station"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.string "from_stop_id", null: false
    t.string "to_stop_id", null: false
    t.integer "transfer_type"
    t.integer "min_transfer_time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "trips", primary_key: "trip_id", id: :string, force: :cascade do |t|
    t.string "route_id"
    t.string "service_id"
    t.string "headsign"
    t.integer "direction"
    t.integer "block"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
