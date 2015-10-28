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

ActiveRecord::Schema.define(version: 20151023145941) do

  create_table "items", force: true do |t|
    t.string   "item_name"
    t.integer  "item_total"
    t.integer  "item_requested"
    t.integer  "item_approved"
    t.integer  "item_remaining"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_alloted"
  end

  create_table "logs", force: true do |t|
    t.integer  "request_id"
    t.integer  "item_id"
    t.integer  "team_id"
    t.integer  "approved"
    t.integer  "requested"
    t.integer  "allotted"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests", force: true do |t|
    t.integer  "team_id"
    t.integer  "item_id"
    t.integer  "requested"
    t.integer  "allotted"
    t.integer  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "team_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "team_type"
  end

  create_table "temp_reqs", force: true do |t|
    t.integer  "team_id"
    t.string   "item_name"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.string   "password"
    t.integer  "team_id"
    t.string   "user_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_type_team"
  end

end
