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

ActiveRecord::Schema.define(:version => 20120525030748) do

  create_table "dojos", :force => true do |t|
    t.integer  "rank_id"
    t.string   "personality", :limit => 7
    t.integer  "level"
    t.string   "leader"
    t.integer  "mbgaid"
    t.string   "force"
    t.integer  "force_value"
    t.text     "description"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "dojos", ["rank_id"], :name => "index_dojos_on_rank_id"

  create_table "ranks", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
