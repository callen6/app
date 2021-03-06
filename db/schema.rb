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

ActiveRecord::Schema.define(version: 20131027215755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: true do |t|
    t.string "unique_id"
    t.string "title"
    t.string "thumbnail"
    t.text   "description"
    t.string "url"
  end

  create_table "movies_users", force: true do |t|
    t.integer "user_id"
    t.integer "movie_id"
  end

  add_index "movies_users", ["movie_id"], name: "index_movies_users_on_movie_id", using: :btree
  add_index "movies_users", ["user_id"], name: "index_movies_users_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string  "provider"
    t.string  "uid"
    t.string  "name"
    t.string  "email"
    t.string  "image"
    t.string  "first_name"
    t.string  "token"
    t.string  "refresh_token"
    t.integer "expires_at"
  end

end
