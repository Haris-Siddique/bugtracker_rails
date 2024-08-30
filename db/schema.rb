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

ActiveRecord::Schema[7.2].define(version: 2024_08_30_160154) do
  create_table "bugs", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.date "deadline"
    t.string "screen_shot"
    t.integer "bug_type"
    t.integer "status", default: 0
    t.integer "project_id"
    t.integer "developer_id"
    t.integer "qa_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.index ["developer_id"], name: "index_bugs_on_developer_id"
    t.index ["manager_id"], name: "index_bugs_on_manager_id"
    t.index ["project_id"], name: "index_bugs_on_project_id"
    t.index ["qa_id"], name: "index_bugs_on_qa_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.integer "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manager_id"], name: "index_projects_on_manager_id"
  end

  create_table "projects_assigneds", force: :cascade do |t|
    t.integer "project_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_projects_assigneds_on_project_id"
    t.index ["user_id"], name: "index_projects_assigneds_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "user_type"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bugs", "projects"
  add_foreign_key "bugs", "users", column: "developer_id"
  add_foreign_key "bugs", "users", column: "manager_id"
  add_foreign_key "bugs", "users", column: "qa_id"
  add_foreign_key "projects", "users", column: "manager_id"
  add_foreign_key "projects_assigneds", "projects"
  add_foreign_key "projects_assigneds", "users"
end
