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

ActiveRecord::Schema.define(version: 20150507212848) do

  create_table "browser_cookies", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.string   "value",          limit: 255
    t.integer  "target_page_id", limit: 4,   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "browser_cookies", ["target_page_id"], name: "index_browser_cookies_on_target_page_id", using: :btree

  create_table "captured_environments", force: :cascade do |t|
    t.string   "name",                    limit: 255
    t.integer  "captured_page_id",        limit: 4,   null: false
    t.string   "screenshot_file_name",    limit: 255
    t.string   "screenshot_content_type", limit: 255
    t.integer  "screenshot_file_size",    limit: 4
    t.datetime "screenshot_updated_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "captured_environments", ["captured_page_id"], name: "index_captured_environments_on_captured_page_id", using: :btree

  create_table "captured_pages", force: :cascade do |t|
    t.integer  "captured_version_id", limit: 4, null: false
    t.integer  "target_page_id",      limit: 4, null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "captured_pages", ["captured_version_id"], name: "index_captured_pages_on_captured_version_id", using: :btree
  add_index "captured_pages", ["target_page_id"], name: "index_captured_pages_on_target_page_id", using: :btree

  create_table "captured_versions", force: :cascade do |t|
    t.integer  "name",       limit: 4, default: 1
    t.integer  "site_id",    limit: 4,             null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "composited_screenshots", force: :cascade do |t|
    t.integer  "before_captured_version_id",     limit: 4,   null: false
    t.integer  "after_captured_version_id",      limit: 4,   null: false
    t.integer  "before_captured_environment_id", limit: 4,   null: false
    t.integer  "after_captured_environment_id",  limit: 4,   null: false
    t.string   "image_file_name",                limit: 255
    t.string   "image_content_type",             limit: 255
    t.integer  "image_file_size",                limit: 4
    t.datetime "image_updated_at"
    t.integer  "averaged_pixel",                 limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "composited_screenshots", ["after_captured_environment_id", "before_captured_environment_id"], name: "comp_b_a_id", using: :btree
  add_index "composited_screenshots", ["after_captured_version_id"], name: "index_composited_screenshots_on_after_captured_version_id", using: :btree
  add_index "composited_screenshots", ["before_captured_environment_id", "after_captured_environment_id"], name: "comp_a_b_id", using: :btree
  add_index "composited_screenshots", ["before_captured_version_id"], name: "index_composited_screenshots_on_before_captured_version_id", using: :btree

  create_table "sites", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "url",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "target_pages", force: :cascade do |t|
    t.string   "path",       limit: 255, null: false
    t.integer  "site_id",    limit: 4,   null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
