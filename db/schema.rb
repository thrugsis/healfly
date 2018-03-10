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

ActiveRecord::Schema.define(version: 20180309102942) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "provider_id"
    t.time     "start_time"
    t.time     "end_time"
    t.date     "date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["provider_id"], name: "index_appointments_on_provider_id", using: :btree
    t.index ["user_id"], name: "index_appointments_on_user_id", using: :btree
  end

  create_table "authentications", force: :cascade do |t|
    t.string   "uid"
    t.string   "token"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "providers", force: :cascade do |t|
    t.integer  "price",         null: false
    t.string   "location",      null: false
    t.string   "name",          null: false
    t.string   "treatment",     null: false
    t.string   "language",      null: false
    t.text     "image",         null: false
    t.text     "qualification", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username",                       null: false
    t.string   "first_name",                     null: false
    t.string   "last_name",                      null: false
    t.string   "email",                          null: false
    t.string   "password"
    t.string   "encrypted_password", limit: 128
    t.string   "remember_token",     limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "gender"
    t.string   "phone_number"
    t.date     "birthday"
    t.text     "image"
    t.text     "medical_history"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "appointments", "providers"
  add_foreign_key "appointments", "users"
  add_foreign_key "authentications", "users"
end
