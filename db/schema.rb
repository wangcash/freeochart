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

ActiveRecord::Schema.define(version: 20130723053130) do

  create_table "bids", force: true do |t|
    t.string   "bid_name"
    t.string   "bid_organ_id"
    t.string   "bid_amount"
    t.string   "bid_number"
    t.date     "bid_begin_date"
    t.date     "bid_finish_date"
    t.string   "city_id"
    t.string   "products_id"
    t.text     "bid_content"
    t.string   "bid_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comps", force: true do |t|
    t.string   "comp_id"
    t.string   "comp_name"
    t.string   "area_code"
    t.string   "tel"
    t.string   "www"
    t.string   "brief"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ocharts", force: true do |t|
    t.string   "ochart_id"
    t.string   "department_name"
    t.string   "parent_id"
    t.string   "comp_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
