# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_06_04_201715) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "festivals", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "zip_code"
  end

  create_table "schedule_shows", force: :cascade do |t|
    t.string "title"
    t.date "date"
    t.bigint "schedule_id", null: false
    t.bigint "show_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["schedule_id"], name: "index_schedule_shows_on_schedule_id"
    t.index ["show_id"], name: "index_schedule_shows_on_show_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "shows", force: :cascade do |t|
    t.string "artist"
    t.string "location"
    t.date "date"
    t.time "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stage_id", null: false
    t.index ["stage_id"], name: "index_shows_on_stage_id"
  end

  create_table "stages", force: :cascade do |t|
    t.string "name"
    t.bigint "festival_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["festival_id"], name: "index_stages_on_festival_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.date "birthday"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "schedule_shows", "schedules"
  add_foreign_key "schedule_shows", "shows"
  add_foreign_key "schedules", "users"
  add_foreign_key "shows", "stages"
  add_foreign_key "stages", "festivals"
end
