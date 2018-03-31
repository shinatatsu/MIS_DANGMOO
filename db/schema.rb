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

ActiveRecord::Schema.define(version: 20180330134931) do

  create_table "dangmoos", force: :cascade do |t|
    t.string "roomid"
    t.string "dangmoo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "keyword_appings", force: :cascade do |t|
    t.string "keyword"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receiveds", force: :cascade do |t|
    t.string "channel_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "replies", force: :cascade do |t|
    t.string "channel_id"
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "room_ids", force: :cascade do |t|
    t.string "roomid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "tel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
