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

ActiveRecord::Schema.define(version: 20140430210218) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "births", force: true do |t|
    t.integer  "child_id"
    t.integer  "father_id"
    t.integer  "mother_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "place_id"
  end

  create_table "deaths", force: true do |t|
    t.integer  "person_id"
    t.date     "date"
    t.integer  "place_id"
    t.string   "cause"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "dead"
  end

  create_table "events", force: true do |t|
    t.string   "type"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "gender"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "spouse_id"
  end

  create_table "places", force: true do |t|
    t.string   "country"
    t.string   "state"
    t.string   "county"
    t.string   "postal_code"
    t.string   "city"
    t.string   "street_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lon"
  end

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "simple_captcha_data", force: true do |t|
    t.string   "key",        limit: 40
    t.string   "value",      limit: 6
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "simple_captcha_data", ["key"], name: "idx_key", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.string   "role"
    t.integer  "person_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree

end
