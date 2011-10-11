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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110724130000) do

  create_table "guestbook_entries", :force => true do |t|
    t.string   "title",                        :null => false
    t.text     "message",                      :null => false
    t.string   "author",                       :null => false
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published",  :default => true
  end

  create_table "quiz_attempts", :force => true do |t|
    t.integer  "quiz_id",                       :null => false
    t.float    "score",                         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "exclude",    :default => false, :null => false
  end

  create_table "quizzes", :force => true do |t|
    t.string   "title",         :null => false
    t.string   "internal_name", :null => false
    t.integer  "weight",        :null => false
    t.boolean  "enabled",       :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",        :null => false
    t.string   "description", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trivia_question_attempts", :force => true do |t|
    t.integer  "trivia_question_id", :null => false
    t.integer  "quiz_attempt_id",    :null => false
    t.string   "selection",          :null => false
    t.boolean  "correct",            :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trivia_question_suggestions", :force => true do |t|
    t.string   "author",             :null => false
    t.string   "email"
    t.string   "suggested_question", :null => false
    t.string   "suggested_answer",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trivia_questions", :force => true do |t|
    t.integer  "quiz_id",               :null => false
    t.integer  "weight",                :null => false
    t.boolean  "enabled",               :null => false
    t.string   "question",              :null => false
    t.text     "correct_answers_raw",   :null => false
    t.text     "incorrect_answers_raw", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "next_version"
  end

  create_table "user_roles", :force => true do |t|
    t.integer  "role_id",    :null => false
    t.integer  "user_id",    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",            :null => false
    t.string   "hashed_password", :null => false
    t.string   "salt",            :null => false
    t.boolean  "enabled",         :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
