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

ActiveRecord::Schema.define(version: 20150110004123) do

  create_table "comments", force: true do |t|
    t.text     "content",           null: false
    t.integer  "author_id",         null: false
    t.integer  "post_id",           null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "parent_comment_id"
  end

  add_index "comments", ["author_id"], name: "index_comments_on_author_id"
  add_index "comments", ["post_id"], name: "index_comments_on_post_id"

  create_table "post_subs", force: true do |t|
    t.integer  "post_id",    null: false
    t.integer  "sub_id",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "post_subs", ["post_id", "sub_id"], name: "index_post_subs_on_post_id_and_sub_id", unique: true
  add_index "post_subs", ["post_id"], name: "index_post_subs_on_post_id"
  add_index "post_subs", ["sub_id"], name: "index_post_subs_on_sub_id"

  create_table "posts", force: true do |t|
    t.string   "title",      null: false
    t.string   "url"
    t.text     "content"
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "subs", force: true do |t|
    t.string   "title",       null: false
    t.text     "description", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subs", ["user_id"], name: "index_subs_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username",        null: false
    t.string   "password_digest", null: false
    t.string   "session_token",   null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
