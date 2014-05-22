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

ActiveRecord::Schema.define(version: 20140522130458) do

  create_table "club_admins", force: true do |t|
    t.integer  "club_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "position"
  end

  create_table "club_events", force: true do |t|
    t.integer  "club_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", force: true do |t|
    t.string   "name"
    t.string   "webLink"
    t.integer  "registrationNumber"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.string   "description"
  end

  create_table "comments", force: true do |t|
    t.string   "username"
    t.text     "body"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["event_id"], name: "index_comments_on_event_id"

  create_table "event_follows", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "location"
    t.date     "event_date"
    t.time     "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "ticket_price"
    t.integer  "num_of_tickets"
    t.string   "ticket_info"
    t.string   "image2_file_name"
    t.string   "image2_content_type"
    t.integer  "image2_file_size"
    t.datetime "image2_updated_at"
    t.string   "image3_file_name"
    t.string   "image3_content_type"
    t.integer  "image3_file_size"
    t.datetime "image3_updated_at"
    t.string   "parent_club"
  end

# Could not dump table "messages" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "users" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
