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

ActiveRecord::Schema.define(:version => 20120625152104) do

  create_table "Person", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "age"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "costs", :force => true do |t|
    t.string   "instance_id", :null => false
    t.float    "cost"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "run_id",      :null => false
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runs", :force => true do |t|
    t.string   "instance_id",     :null => false
    t.datetime "start_time"
    t.datetime "stop_time"
    t.string   "region"
    t.string   "instance_state"
    t.string   "instance_flavor"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "run_id",     :null => false
    t.string   "key"
    t.string   "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "utilizations", :force => true do |t|
    t.string   "instance_id", :null => false
    t.float    "cpu"
    t.float    "network"
    t.datetime "from"
    t.datetime "to"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "run_id",      :null => false
  end

end
