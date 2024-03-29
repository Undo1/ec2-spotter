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

ActiveRecord::Schema.define(version: 20170202003545) do

  create_table "availability_zones", force: :cascade do |t|
    t.string   "api_name"
    t.integer  "region_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "instance_types", force: :cascade do |t|
    t.string   "api_name"
    t.decimal  "standard_price"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "regions", force: :cascade do |t|
    t.string   "api_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "spot_prices", force: :cascade do |t|
    t.decimal  "price"
    t.integer  "availability_zone_id"
    t.integer  "instance_type_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

end
