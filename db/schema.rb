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

ActiveRecord::Schema.define(version: 20140818180551) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "opening_hours", force: true do |t|
    t.integer "place_id"
    t.integer "week_day", null: false
    t.time    "open",     null: false
    t.time    "close",    null: false
  end

  add_index "opening_hours", ["place_id", "week_day"], name: "index_opening_hours_on_place_id_and_week_day", unique: true, using: :btree

  create_table "places", force: true do |t|
    t.string   "name",                                       null: false
    t.string   "address_line_1", limit: 80,                  null: false
    t.string   "address_line_2", limit: 80
    t.string   "city",           limit: 80,                  null: false
    t.string   "district"
    t.string   "postal_code",                                null: false
    t.string   "main_phone"
    t.string   "home_page"
    t.float    "lat"
    t.float    "lon"
    t.string   "images",                                                  array: true
    t.string   "description",    limit: 200
    t.string   "email"
    t.string   "alt_phone"
    t.string   "mobile_phone"
    t.string   "fax"
    t.boolean  "only_cash",                  default: false, null: false
    t.string   "categories",                                 null: false, array: true
    t.integer  "state_id",                                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "shop_id",                                    null: false
    t.string   "videos",                                                  array: true
  end

  create_table "shops", force: true do |t|
    t.string "name",             null: false
    t.string "token", limit: 32, null: false
  end

  add_index "shops", ["token"], name: "index_shops_on_token", unique: true, using: :btree

  create_table "states", force: true do |t|
    t.string "uf",   limit: 2,  null: false
    t.string "name", limit: 20, null: false
  end

  add_foreign_key "opening_hours", "places", name: "opening_hours_place_id_fk", dependent: :delete

  add_foreign_key "places", "shops", name: "places_shop_id_fk"
  add_foreign_key "places", "states", name: "places_state_id_fk"

end
