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

ActiveRecord::Schema.define(version: 20160118083626) do

  create_table "addresses", force: :cascade do |t|
    t.string   "line1"
    t.string   "line2"
    t.string   "city"
    t.integer  "state_id"
    t.string   "zip"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "addresses", ["addressable_id", "addressable_type"], name: "index_addresses_on_addressable_id_and_addressable_type", unique: true
  add_index "addresses", ["state_id"], name: "index_addresses_on_state_id"

  create_table "athlete_stories", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "athlete_stories", ["user_id"], name: "index_athlete_stories_on_user_id"

  create_table "boulder_logs", force: :cascade do |t|
    t.integer  "grade"
    t.integer  "quality_rating"
    t.text     "note"
    t.boolean  "project"
    t.integer  "athlete_story_id"
    t.integer  "boulder_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "boulder_logs", ["athlete_story_id"], name: "index_boulder_logs_on_athlete_story_id"
  add_index "boulder_logs", ["boulder_id"], name: "index_boulder_logs_on_boulder_id"

  create_table "boulders", force: :cascade do |t|
    t.string   "name"
    t.integer  "grade"
    t.string   "picture"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "setter_story_id"
  end

  add_index "boulders", ["setter_story_id"], name: "index_boulders_on_setter_story_id"

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "setter_stories", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "setter_stories", ["user_id"], name: "index_setter_stories_on_user_id"

  create_table "states", force: :cascade do |t|
    t.string   "postal_abbreviation", limit: 2
    t.string   "full_name",           limit: 50
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "user_names", force: :cascade do |t|
    t.string  "first"
    t.string  "last"
    t.integer "user_id"
  end

  add_index "user_names", ["user_id"], name: "index_user_names_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "current_role"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
