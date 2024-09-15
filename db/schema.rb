# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2024_09_15_163444) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "leasing_offers", force: :cascade do |t|
    t.bigint "vehicle_id"
    t.bigint "vehicle_configuration_id"
    t.string "description"
    t.decimal "monthly_price"
    t.integer "duration"
    t.decimal "mileage"
    t.decimal "price_primary"
    t.decimal "price_secondary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vehicle_configuration_id"], name: "index_leasing_offers_on_vehicle_configuration_id"
    t.index ["vehicle_id"], name: "index_leasing_offers_on_vehicle_id"
  end

  create_table "vehicle_configurations", force: :cascade do |t|
    t.integer "vehicle_type"
    t.integer "fuel"
    t.integer "transmission"
    t.integer "year"
    t.integer "horse_power"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "brand_name"
    t.string "model_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "leasing_offers", "vehicle_configurations"
  add_foreign_key "leasing_offers", "vehicles"
end
