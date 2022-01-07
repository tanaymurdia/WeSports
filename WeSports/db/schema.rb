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

ActiveRecord::Schema.define(version: 20211117210448) do

  create_table "games", force: :cascade do |t|
    t.string   "sport_name"
    t.string   "address"
    t.string   "zipcode"
    t.integer  "slots_to_be_filled"
    t.datetime "game_start_time"
    t.datetime "game_end_time"
    t.integer  "owning_player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games_players", id: false, force: :cascade do |t|
    t.integer "game_id",   null: false
    t.integer "player_id", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
