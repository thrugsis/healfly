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

ActiveRecord::Schema.define(version: 20180316090535) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "provider_id"
    t.time     "start_time"
    t.time     "end_time"
    t.date     "date"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "payment_status", default: false
    t.integer  "payment_amount"
    t.index ["patient_id"], name: "index_appointments_on_patient_id", using: :btree
    t.index ["provider_id"], name: "index_appointments_on_provider_id", using: :btree
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                         null: false
    t.string   "first_name",                       null: false
    t.string   "last_name",                        null: false
    t.string   "email",                            null: false
    t.string   "encrypted_password",   limit: 128
    t.string   "remember_token",       limit: 128
    t.string   "confirmation_token",   limit: 128
    t.string   "gender"
    t.string   "phone_number"
    t.date     "birthday"
    t.text     "image"
    t.text     "medical_history"
    t.integer  "price"
    t.string   "location"
    t.string   "name"
    t.string   "treatment"
    t.string   "language"
    t.text     "qualification"
    t.string   "type",                           null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "default_picture"
    t.string   "fb_picture"
    t.string   "profile_picture"
    t.json     "profile_picture_json"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "authentications", "users"
end
