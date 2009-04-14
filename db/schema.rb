# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090414114233) do

  create_table "boats", :force => true do |t|
    t.integer  "number"
    t.string   "entered_in"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
    t.boolean  "start",      :default => false
    t.boolean  "finish",     :default => false
    t.float    "distance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "paddlers", :force => true do |t|
    t.string   "surname"
    t.string   "first_name"
    t.string   "gender"
    t.string   "club"
    t.integer  "position"
    t.integer  "boat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "results", :force => true do |t|
    t.integer  "boat_id"
    t.string   "time"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timings", :force => true do |t|
    t.string   "time"
    t.string   "notes"
    t.string   "location_id"
    t.integer  "boat_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
