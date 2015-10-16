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

ActiveRecord::Schema.define(version: 20151016045204) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contests", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.integer  "entry",                       null: false
    t.integer  "cap",         default: 50000, null: false
    t.integer  "min_entries", default: 1,     null: false
    t.integer  "max_entries",                 null: false
    t.datetime "settled_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "round_id",                    null: false
  end

  add_index "contests", ["round_id"], name: "index_contests_on_round_id", using: :btree
  add_index "contests", ["settled_at"], name: "index_contests_on_settled_at", using: :btree
  add_index "contests", ["user_id"], name: "index_contests_on_user_id", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "contest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "entries", ["contest_id"], name: "index_entries_on_contest_id", using: :btree
  add_index "entries", ["user_id", "contest_id"], name: "index_entries_on_user_id_and_contest_id", unique: true, using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer  "team_id",    null: false
    t.string   "name",       null: false
    t.string   "position",   null: false
    t.integer  "salary",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "players", ["position"], name: "index_players_on_position", using: :btree
  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "rounds", force: :cascade do |t|
    t.integer  "sport_id",   null: false
    t.string   "name",       null: false
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rounds", ["closed_at"], name: "index_rounds_on_closed_at", using: :btree
  add_index "rounds", ["opened_at"], name: "index_rounds_on_opened_at", using: :btree
  add_index "rounds", ["sport_id"], name: "index_rounds_on_sport_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.integer  "sport_id"
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams", ["sport_id", "name"], name: "index_teams_on_sport_id_and_name", unique: true, using: :btree
  add_index "teams", ["sport_id"], name: "index_teams_on_sport_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.boolean  "admin",                  default: false, null: false
    t.integer  "credit",                 default: 0,     null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "contests", "rounds"
  add_foreign_key "contests", "users"
  add_foreign_key "entries", "contests"
  add_foreign_key "entries", "users"
  add_foreign_key "players", "teams"
  add_foreign_key "rounds", "sports"
  add_foreign_key "teams", "sports"
end
