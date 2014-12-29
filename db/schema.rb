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

ActiveRecord::Schema.define(version: 20140212184016) do

  create_table "adjudicators", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "competition_id"
    t.string   "shorthand"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adjudicators_rounds", id: false, force: :cascade do |t|
    t.integer "adjudicator_id", null: false
    t.integer "round_id",       null: false
  end

  add_index "adjudicators_rounds", ["adjudicator_id", "round_id"], name: "index_adjudicators_rounds_on_adjudicator_id_and_round_id", unique: true

  create_table "competitions", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

# Could not dump table "couple_round_tallies" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "couples", force: :cascade do |t|
    t.integer  "lead_id"
    t.integer  "follow_id"
    t.integer  "event_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "couples_rounds", id: false, force: :cascade do |t|
    t.integer "couple_id", null: false
    t.integer "round_id",  null: false
  end

  add_index "couples_rounds", ["couple_id", "round_id"], name: "index_couples_rounds_on_couple_id_and_round_id", unique: true

  create_table "dances", force: :cascade do |t|
    t.string   "name"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "base_name"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "competition_id"
    t.integer  "level_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: :cascade do |t|
    t.string   "name"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marks", force: :cascade do |t|
    t.integer  "adjudicator_id"
    t.integer  "sub_round_id"
    t.integer  "couple_id"
    t.integer  "placement"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "marks", ["couple_id", "sub_round_id"], name: "index_marks_on_couple_id_and_sub_round_id"

  create_table "placements", force: :cascade do |t|
    t.integer  "couple_id"
    t.integer  "event_id"
    t.integer  "rank"
    t.integer  "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "placements", ["couple_id"], name: "index_placements_on_couple_id"
  add_index "placements", ["event_id"], name: "index_placements_on_event_id"

  create_table "rounds", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "number"
    t.boolean  "final"
    t.integer  "requested"
    t.integer  "cutoff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sections", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_events", force: :cascade do |t|
    t.integer  "event_id"
    t.integer  "dance_id"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_placements", force: :cascade do |t|
    t.integer  "couple_id"
    t.integer  "sub_event_id"
    t.decimal  "rank",         precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_placements", ["couple_id"], name: "index_sub_placements_on_couple_id"
  add_index "sub_placements", ["sub_event_id"], name: "index_sub_placements_on_sub_event_id"

  create_table "sub_rounds", force: :cascade do |t|
    t.integer  "round_id"
    t.integer  "sub_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sub_rounds", ["round_id"], name: "index_sub_rounds_on_round_id"
  add_index "sub_rounds", ["sub_event_id"], name: "index_sub_rounds_on_sub_event_id"

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
