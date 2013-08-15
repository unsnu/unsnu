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

ActiveRecord::Schema.define(version: 20130815095725) do

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "nickname"
    t.text     "content"
    t.integer  "upvote"
    t.integer  "downvote"
    t.integer  "comment_count"
    t.boolean  "locked?"
    t.integer  "view_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boards", force: true do |t|
    t.string   "name"
    t.boolean  "anonymous?"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "nickname"
    t.string   "content"
    t.boolean  "has_children?"
    t.integer  "parent_id"
    t.integer  "cascade_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id"

  create_table "messages", force: true do |t|
    t.string   "title"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "snuid_digest"
    t.date     "anonymous_available_date"
    t.string   "anonymous_nickname"
    t.string   "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
