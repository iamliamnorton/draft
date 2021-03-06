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

ActiveRecord::Schema.define(version: 20151018044409) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contests", force: :cascade do |t|
    t.integer  "user_id",                     null: false
    t.integer  "round_id",                    null: false
    t.integer  "entry",                       null: false
    t.integer  "salary_cap",  default: 50000, null: false
    t.integer  "min_entries", default: 1,     null: false
    t.integer  "max_entries",                 null: false
    t.datetime "settled_at"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "contests", ["round_id"], name: "index_contests_on_round_id", using: :btree
  add_index "contests", ["settled_at"], name: "index_contests_on_settled_at", using: :btree
  add_index "contests", ["user_id"], name: "index_contests_on_user_id", using: :btree

  create_table "draft_picks", force: :cascade do |t|
    t.integer  "roster_id",  null: false
    t.integer  "player_id",  null: false
    t.integer  "cost",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "draft_picks", ["player_id"], name: "index_draft_picks_on_player_id", using: :btree
  add_index "draft_picks", ["roster_id", "player_id"], name: "index_draft_picks_on_roster_id_and_player_id", unique: true, using: :btree
  add_index "draft_picks", ["roster_id"], name: "index_draft_picks_on_roster_id", using: :btree

  create_table "entries", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "contest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "entries", ["contest_id"], name: "index_entries_on_contest_id", using: :btree
  add_index "entries", ["user_id", "contest_id"], name: "index_entries_on_user_id_and_contest_id", unique: true, using: :btree
  add_index "entries", ["user_id"], name: "index_entries_on_user_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "season_id",    null: false
    t.integer  "round_id",     null: false
    t.integer  "home_team_id", null: false
    t.integer  "away_team_id", null: false
    t.integer  "source_id"
    t.datetime "started_at"
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "games", ["away_team_id"], name: "index_games_on_away_team_id", using: :btree
  add_index "games", ["completed_at"], name: "index_games_on_completed_at", using: :btree
  add_index "games", ["home_team_id"], name: "index_games_on_home_team_id", using: :btree
  add_index "games", ["round_id"], name: "index_games_on_round_id", using: :btree
  add_index "games", ["season_id"], name: "index_games_on_season_id", using: :btree
  add_index "games", ["source_id"], name: "index_games_on_source_id", using: :btree
  add_index "games", ["started_at"], name: "index_games_on_started_at", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "source_id"
    t.string   "name",                    null: false
    t.string   "position",   default: "", null: false
    t.integer  "salary",     default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "players", ["position"], name: "index_players_on_position", using: :btree
  add_index "players", ["source_id"], name: "index_players_on_source_id", using: :btree
  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "rosters", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "contest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "rosters", ["contest_id"], name: "index_rosters_on_contest_id", using: :btree
  add_index "rosters", ["user_id", "contest_id"], name: "index_rosters_on_user_id_and_contest_id", unique: true, using: :btree
  add_index "rosters", ["user_id"], name: "index_rosters_on_user_id", using: :btree

  create_table "rounds", force: :cascade do |t|
    t.string   "name",         null: false
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "rounds", ["closed_at"], name: "index_rounds_on_closed_at", using: :btree
  add_index "rounds", ["completed_at"], name: "index_rounds_on_completed_at", using: :btree
  add_index "rounds", ["opened_at"], name: "index_rounds_on_opened_at", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.string   "name",                         null: false
    t.string   "year",                         null: false
    t.integer  "max_draft_picks", default: 10, null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "player_id",              null: false
    t.integer  "game_id",                null: false
    t.integer  "points",     default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "stats", ["game_id"], name: "index_stats_on_game_id", using: :btree
  add_index "stats", ["player_id"], name: "index_stats_on_player_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.integer  "season_id",    null: false
    t.string   "name",         null: false
    t.string   "city"
    t.string   "abbreviation"
    t.integer  "source_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "teams", ["season_id"], name: "index_teams_on_season_id", using: :btree
  add_index "teams", ["source_id"], name: "index_teams_on_source_id", using: :btree

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
  add_foreign_key "draft_picks", "players"
  add_foreign_key "draft_picks", "rosters"
  add_foreign_key "entries", "contests"
  add_foreign_key "entries", "users"
  add_foreign_key "games", "rounds"
  add_foreign_key "games", "seasons"
  add_foreign_key "games", "teams", column: "away_team_id"
  add_foreign_key "games", "teams", column: "home_team_id"
  add_foreign_key "players", "teams"
  add_foreign_key "rosters", "contests"
  add_foreign_key "rosters", "users"
  add_foreign_key "stats", "games"
  add_foreign_key "stats", "players"
  add_foreign_key "teams", "seasons"
end
