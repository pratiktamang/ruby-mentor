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

ActiveRecord::Schema[7.0].define(version: 2023_04_10_035840) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "meetings", force: :cascade do |t|
    t.string "title"
    t.datetime "date_time"
    t.bigint "mentor_id", null: false
    t.bigint "mentee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentee_id"], name: "index_meetings_on_mentee_id"
    t.index ["mentor_id"], name: "index_meetings_on_mentor_id"
  end

  create_table "mentee_profiles", force: :cascade do |t|
    t.bigint "mentee_id", null: false
    t.string "country"
    t.string "city"
    t.string "workplace_url"
    t.boolean "writing_ruby"
    t.string "start_source"
    t.string "underrepresented_group"
    t.string "twitter"
    t.string "github"
    t.string "personal_site"
    t.string "other_languages"
    t.string "past_career"
    t.text "mentoring_goals"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentee_id"], name: "index_mentee_profiles_on_mentee_id"
  end

  create_table "mentees", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.boolean "onboarded", default: false
    t.boolean "seeking_mentorhip", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mentees_on_email", unique: true
    t.index ["reset_password_token"], name: "index_mentees_on_reset_password_token", unique: true
  end

  create_table "mentor_profiles", force: :cascade do |t|
    t.bigint "mentor_id", null: false
    t.string "company_url"
    t.date "ruby_start_year"
    t.string "country"
    t.string "city"
    t.string "twitter"
    t.string "github"
    t.string "personal_site"
    t.text "past_workplaces"
    t.boolean "previous_mentoring"
    t.text "motivation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentor_id"], name: "index_mentor_profiles_on_mentor_id"
  end

  create_table "mentors", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.boolean "onboarded", default: false
    t.boolean "available", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_mentors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_mentors_on_reset_password_token", unique: true
  end

  create_table "mentorships", force: :cascade do |t|
    t.bigint "mentor_id", null: false
    t.bigint "mentee_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentee_id"], name: "index_mentorships_on_mentee_id"
    t.index ["mentor_id"], name: "index_mentorships_on_mentor_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status"
    t.bigint "mentee_id", null: false
    t.bigint "mentor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentee_id"], name: "index_projects_on_mentee_id"
    t.index ["mentor_id"], name: "index_projects_on_mentor_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "status"
    t.bigint "project_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  add_foreign_key "meetings", "mentees"
  add_foreign_key "meetings", "mentors"
  add_foreign_key "mentee_profiles", "mentees"
  add_foreign_key "mentor_profiles", "mentors"
  add_foreign_key "mentorships", "mentees"
  add_foreign_key "mentorships", "mentors"
  add_foreign_key "projects", "mentees"
  add_foreign_key "projects", "mentors"
  add_foreign_key "tasks", "projects"
end
