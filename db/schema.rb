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

ActiveRecord::Schema.define(version: 2021_06_16_173109) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.bigint "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["form_id"], name: "index_answers_on_form_id"
  end

  create_table "forms", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "primary_color"
    t.boolean "enable"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_forms_on_slug", unique: true
    t.index ["user_id"], name: "index_forms_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "title"
    t.integer "kind"
    t.boolean "mandatory"
    t.integer "order"
    t.bigint "form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["form_id"], name: "index_questions_on_form_id"
    t.index ["slug"], name: "index_questions_on_slug", unique: true
  end

  create_table "questions_answers", force: :cascade do |t|
    t.text "value"
    t.bigint "answer_id"
    t.bigint "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_questions_answers_on_answer_id"
    t.index ["question_id"], name: "index_questions_answers_on_question_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "answers", "forms"
  add_foreign_key "forms", "users"
  add_foreign_key "questions", "forms"
  add_foreign_key "questions_answers", "answers"
  add_foreign_key "questions_answers", "questions"
end
