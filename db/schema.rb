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

ActiveRecord::Schema.define(version: 20160527161210) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "episodes", force: :cascade do |t|
    t.integer  "show_id",     limit: 4
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.text     "transcript",  limit: 65535
    t.integer  "stage",       limit: 4
    t.integer  "number",      limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.integer  "duration",    limit: 4
  end

  add_index "episodes", ["name"], name: "index_episodes_on_name", using: :btree
  add_index "episodes", ["show_id"], name: "index_episodes_on_show_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "ref_link",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "images", ["ref_link"], name: "index_images_on_ref_link", using: :btree
  add_index "images", ["user_id"], name: "index_images_on_user_id", using: :btree

  create_table "mediafiles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "user_id",    limit: 4
    t.string   "ref_link",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "attachment", limit: 255
    t.integer  "episode_id", limit: 4
  end

  add_index "mediafiles", ["episode_id"], name: "index_mediafiles_on_episode_id", using: :btree
  add_index "mediafiles", ["ref_link"], name: "index_mediafiles_on_ref_link", using: :btree
  add_index "mediafiles", ["user_id"], name: "index_mediafiles_on_user_id", using: :btree

  create_table "mp3files", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "attachment", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "user_id",    limit: 4
    t.integer  "duration",   limit: 4
  end

  create_table "pages", force: :cascade do |t|
    t.integer  "subject_id", limit: 4
    t.string   "name",       limit: 255
    t.integer  "permalink",  limit: 4
    t.integer  "position",   limit: 4
    t.boolean  "visible",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "pages", ["permalink"], name: "index_pages_on_permalink", using: :btree
  add_index "pages", ["subject_id"], name: "index_pages_on_subject_id", using: :btree

  create_table "pages_users", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4
    t.integer "page_id", limit: 4
  end

  add_index "pages_users", ["user_id", "page_id"], name: "index_pages_users_on_user_id_and_page_id", using: :btree

  create_table "section_edits", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "section_id", limit: 4
    t.string   "summary",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "section_edits", ["user_id", "section_id"], name: "index_section_edits_on_user_id_and_section_id", using: :btree

  create_table "sections", force: :cascade do |t|
    t.integer  "page_id",      limit: 4
    t.string   "name",         limit: 255
    t.integer  "position",     limit: 4
    t.boolean  "visible",                    default: false
    t.string   "content_type", limit: 255
    t.text     "content",      limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  add_index "sections", ["page_id"], name: "index_sections_on_page_id", using: :btree

  create_table "shows", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.integer  "stage",       limit: 4
    t.integer  "image_id",    limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "shows", ["image_id"], name: "index_shows_on_image_id", using: :btree
  add_index "shows", ["name"], name: "index_shows_on_name", using: :btree
  add_index "shows", ["user_id"], name: "index_shows_on_user_id", using: :btree

  create_table "streamitems", force: :cascade do |t|
    t.string   "episode_id", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.date     "date"
    t.integer  "position",   limit: 4
  end

  add_index "streamitems", ["episode_id"], name: "index_streamitems_on_episode_id", using: :btree

  create_table "subjects", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "position",   limit: 4
    t.boolean  "visible",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",      limit: 25
    t.string   "last_name",       limit: 50
    t.string   "email",           limit: 255, default: "", null: false
    t.integer  "access_level",    limit: 4,   default: 0
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "password_digest", limit: 255
  end

end
