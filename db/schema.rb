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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130806104952) do

  create_table "fixtures", :force => true do |t|
    t.string   "content"
    t.datetime "matchdate"
    t.string   "hometeam"
    t.string   "awayteam"
    t.integer  "game_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "matchhomescore"
    t.integer  "matchawayscore"
    t.time     "ko"
    t.integer  "week"
    t.integer  "fixresultgap"
  end

  add_index "fixtures", ["game_id", "created_at"], :name => "index_fixtures_on_game_id_and_created_at"

  create_table "games", :force => true do |t|
    t.string   "name"
    t.date     "startdate"
    t.date     "enddate"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "predicts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "homescore"
    t.integer  "awayscore"
    t.integer  "points"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.integer  "game_id"
    t.integer  "fixture_id"
    t.boolean  "correct_result"
    t.integer  "right_result"
    t.integer  "closest_to_home"
    t.integer  "closest_to_away"
    t.integer  "exact_home_score"
    t.integer  "exact_away_score"
    t.integer  "exact_result"
    t.integer  "val_right_result"
    t.integer  "val_closest_to_home"
    t.integer  "val_closest_to_away"
    t.integer  "val_exact_home_score"
    t.integer  "val_exact_away_score"
    t.integer  "val_exact_result"
  end

  create_table "scoreboards", :force => true do |t|
    t.integer  "week"
    t.integer  "game_id"
    t.integer  "position"
    t.text     "comment"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "fixture_id"
    t.integer  "user_id"
    t.integer  "matchscore"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "admin"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
    t.string   "remember_token"
  end

  add_index "users", ["name"], :name => "index_users_on_name", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
