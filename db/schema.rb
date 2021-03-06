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

ActiveRecord::Schema.define(version: 20170202172257) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "delivery_loads", force: :cascade do |t|
    t.datetime "date"
    t.string   "delivery_shift"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "driver_id"
    t.index ["driver_id"], name: "index_delivery_loads_on_driver_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.datetime "delivery_date"
    t.string   "delivery_shift"
    t.string   "client_name"
    t.string   "destination_raw_line_1"
    t.string   "destination_city"
    t.integer  "destination_zip"
    t.string   "phone_number"
    t.string   "purchase_order_number"
    t.float    "volume"
    t.integer  "handling_unit_quantity"
    t.string   "state"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "delivery_load_id"
    t.datetime "original_delivery_date"
    t.string   "reason_for_check"
    t.index ["delivery_load_id"], name: "index_orders_on_delivery_load_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "role"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "shift"
  end

  add_foreign_key "delivery_loads", "users", column: "driver_id"
  add_foreign_key "orders", "delivery_loads"
end
