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

ActiveRecord::Schema.define(version: 20161030210040) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string   "suit"
    t.string   "rank"
    t.string   "cardable_type"
    t.integer  "cardable_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["cardable_type", "cardable_id"], name: "index_cards_on_cardable_type_and_cardable_id", using: :btree
  end

  create_table "decks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "game_id",    null: false
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "balance"
    t.boolean  "completed",  default: false
  end

  create_table "hands", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "round_id"
    t.boolean  "is_dealer",  default: false, null: false
    t.index ["round_id"], name: "index_hands_on_round_id", using: :btree
  end

  create_table "rounds", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "bet",        default: 0
    t.integer  "game_id"
    t.boolean  "completed",  default: false
    t.boolean  "doubled",    default: false
    t.string   "result"
  end

  add_foreign_key "decks", "games"
  add_foreign_key "rounds", "games"
end
