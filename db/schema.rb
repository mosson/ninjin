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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130626111953) do

  create_table "logs", :force => true do |t|
    t.string   "entry"
    t.datetime "timestamp"
    t.string   "environment"
    t.integer  "error_status"
    t.boolean  "github_issued"
    t.boolean  "closed"
    t.datetime "updated"
    t.string   "ip_address"
  end

  add_index "logs", ["timestamp", "environment", "error_status"], :name => "index_logs_on_timestamp_and_environment_and_error_status", :unique => true

end
