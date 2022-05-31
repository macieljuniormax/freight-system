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

ActiveRecord::Schema[7.0].define(version: 2022_05_30_225018) do
  create_table "carriers", force: :cascade do |t|
    t.string "brand_name"
    t.string "corporate_name"
    t.string "email_domain"
    t.string "registration_number"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
  end

  create_table "deadlines", force: :cascade do |t|
    t.integer "min_distance"
    t.integer "max_distance"
    t.integer "deadline_days"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_deadlines_on_carrier_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "pickup_address"
    t.string "delivery_address"
    t.decimal "height"
    t.decimal "width"
    t.decimal "length"
    t.decimal "weight"
    t.string "code"
    t.string "receiver_name"
    t.integer "carrier_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vehicle_id"
    t.integer "status", default: 0
    t.index ["carrier_id"], name: "index_orders_on_carrier_id"
    t.index ["vehicle_id"], name: "index_orders_on_vehicle_id"
  end

  create_table "price_queries", force: :cascade do |t|
    t.decimal "height"
    t.decimal "width"
    t.decimal "length"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "weight"
    t.integer "distance"
  end

  create_table "prices", force: :cascade do |t|
    t.decimal "min_volume"
    t.decimal "max_volume"
    t.decimal "min_weight"
    t.decimal "max_weight"
    t.decimal "price_km"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_prices_on_carrier_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.integer "carrier_id"
    t.index ["carrier_id"], name: "index_users_on_carrier_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "plate"
    t.string "brand_name"
    t.string "model"
    t.integer "year_manufacture"
    t.integer "capacity"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_vehicles_on_carrier_id"
  end

  add_foreign_key "deadlines", "carriers"
  add_foreign_key "orders", "carriers"
  add_foreign_key "orders", "vehicles"
  add_foreign_key "prices", "carriers"
  add_foreign_key "users", "carriers"
  add_foreign_key "vehicles", "carriers"
end
