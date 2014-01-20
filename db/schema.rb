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

ActiveRecord::Schema.define(version: 20140120191726) do

  create_table "adjudicators", force: true do |t|
    t.integer  "user_id"
    t.integer  "competition_id"
    t.string   "shorthand"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rounds", force: true do |t|
    t.integer  "event_id"
    t.integer  "number"
    t.boolean  "final"
    t.integer  "requested"
    t.integer  "cutoff"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "adjudicators_rounds", id: false, force: true do |t|
    t.integer "adjudicator_id", null: false
    t.integer "round_id",       null: false
    t.index ["adjudicator_id", "round_id"], :name => "index_adjudicators_rounds_on_adjudicator_id_and_round_id", :unique => true
    t.index ["adjudicator_id"], :name => "fk__adjudicators_rounds_adjudicator_id"
    t.index ["round_id"], :name => "fk__adjudicators_rounds_round_id"
    t.foreign_key ["adjudicator_id"], "adjudicators", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_adjudicators_rounds_adjudicator_id"
    t.foreign_key ["round_id"], "rounds", ["id"], :on_update => :no_action, :on_delete => :no_action, :name => "fk_adjudicators_rounds_round_id"
  end

  create_table "competitions", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "couples", force: true do |t|
    t.integer  "lead_id"
    t.integer  "follow_id"
    t.integer  "event_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "marks", force: true do |t|
    t.integer  "adjudicator_id"
    t.integer  "sub_round_id"
    t.integer  "couple_id"
    t.integer  "placement"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["couple_id", "sub_round_id"], :name => "index_marks_on_couple_id_and_sub_round_id"
  end

  create_table "sub_rounds", force: true do |t|
    t.integer  "round_id"
    t.integer  "sub_event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["round_id"], :name => "index_sub_rounds_on_round_id"
    t.index ["sub_event_id"], :name => "index_sub_rounds_on_sub_event_id"
  end

  create_view "couple_round_tallies", "SELECT couples.id AS couple_id,\n             count(marks.id) AS num_marks,\n             rounds.id AS round_id\n      FROM rounds\n      INNER JOIN sub_rounds ON sub_rounds.round_id = rounds.id\n      INNER JOIN marks ON marks.sub_round_id = sub_rounds.id\n      INNER JOIN couples ON couples.id = marks.couple_id\n      GROUP BY couples.id, rounds.id", :force => true
  create_table "couples_rounds", id: false, force: true do |t|
    t.integer "couple_id"
    t.integer "round_id"
    t.index ["couple_id", "round_id"], :name => "index_couples_rounds_on_couple_id_and_round_id", :unique => true
  end

  create_table "dances", force: true do |t|
    t.string   "name"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "base_name"
  end

  create_table "events", force: true do |t|
    t.integer  "competition_id"
    t.integer  "level_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "levels", force: true do |t|
    t.string   "name"
    t.integer  "weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "placements", force: true do |t|
    t.integer  "couple_id"
    t.integer  "event_id"
    t.integer  "rank"
    t.integer  "rule"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["couple_id"], :name => "index_placements_on_couple_id"
    t.index ["event_id"], :name => "index_placements_on_event_id"
  end

  create_table "sections", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_events", force: true do |t|
    t.integer  "event_id"
    t.integer  "dance_id"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sub_placements", force: true do |t|
    t.integer  "couple_id"
    t.integer  "sub_event_id"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["couple_id"], :name => "index_sub_placements_on_couple_id"
    t.index ["sub_event_id"], :name => "index_sub_placements_on_sub_event_id"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
