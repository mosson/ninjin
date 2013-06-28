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

ActiveRecord::Schema.define(:version => 20130628075925) do

  create_table "logs", :force => true do |t|
    t.string   "entry",         :limit => 40000
    t.datetime "occurred_date"
    t.string   "environment"
    t.integer  "error_status"
    t.boolean  "is_issued"
    t.boolean  "is_closed"
    t.datetime "is_updated"
    t.string   "ip_address"
  end

  add_index "logs", ["occurred_date", "environment", "error_status"], :name => "altered_logs_index", :unique => true

end
