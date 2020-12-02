# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_02_121710) do

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.integer "testcaseCount"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "code", limit: 700000
  end

  create_table "testcases", force: :cascade do |t|
    t.integer "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "testfile_file_name"
    t.string "testfile_content_type"
    t.integer "testfile_file_size"
    t.datetime "testfile_updated_at"
    t.string "output_file_name"
    t.string "output_content_type"
    t.integer "output_file_size"
    t.datetime "output_updated_at"
  end

  create_table "tests", force: :cascade do |t|
    t.string "name"
    t.integer "lowlimit"
    t.integer "highlimit"
    t.integer "rowsize"
    t.integer "colsize"
    t.integer "flag"
    t.integer "project_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
