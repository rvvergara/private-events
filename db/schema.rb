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

ActiveRecord::Schema.define(version: 2018_12_27_052313) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.integer "event_id"
    t.integer "attendee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendee_id", "event_id"], name: "index_attendances_on_attendee_id_and_event_id", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.datetime "date"
    t.integer "creator_id"
    t.string "venue"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.string "picture"
    t.index ["creator_id"], name: "index_events_on_creator_id"
  end

  create_table "invitations", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "invitee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "responded", default: false
    t.boolean "accepted"
    t.index ["event_id"], name: "index_invitations_on_event_id"
    t.index ["invitee_id", "event_id"], name: "index_invitations_on_invitee_id_and_event_id", unique: true
    t.index ["invitee_id"], name: "index_invitations_on_invitee_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "events", "users", column: "creator_id"
  add_foreign_key "invitations", "events"
  add_foreign_key "invitations", "users", column: "invitee_id"
end
