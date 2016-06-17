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

ActiveRecord::Schema.define(version: 20160617145155) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "shift_events", force: :cascade do |t|
    t.integer  "shift_id",    null: false
    t.string   "action",      null: false
    t.datetime "occurred_at", null: false
    t.text     "signature"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "shift_events", ["shift_id"], name: "index_shift_events_on_shift_id", using: :btree

  create_table "shifts", force: :cascade do |t|
    t.integer  "work_site_id", null: false
    t.integer  "volunteer_id", null: false
    t.date     "day",          null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "shifts", ["volunteer_id"], name: "index_shifts_on_volunteer_id", using: :btree
  add_index "shifts", ["work_site_id"], name: "index_shifts_on_work_site_id", using: :btree

  create_table "volunteers", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "work_sites", force: :cascade do |t|
    t.text     "address",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "shift_events", "shifts"
  add_foreign_key "shifts", "volunteers"
  add_foreign_key "shifts", "work_sites"
end
