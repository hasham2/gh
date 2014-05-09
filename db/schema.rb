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

ActiveRecord::Schema.define(version: 20140509120059) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certifications", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "certifications_jobs", id: false, force: true do |t|
    t.integer "certification_id"
    t.integer "job_id"
  end

  add_index "certifications_jobs", ["certification_id", "job_id"], name: "index_certifications_jobs_on_certification_id_and_job_id", using: :btree

  create_table "certifications_users", id: false, force: true do |t|
    t.integer "certification_id", null: false
    t.integer "user_id",          null: false
  end

  add_index "certifications_users", ["certification_id", "user_id"], name: "index_certifications_users_on_certification_id_and_user_id", using: :btree
  add_index "certifications_users", ["user_id", "certification_id"], name: "index_certifications_users_on_user_id_and_certification_id", using: :btree

  create_table "employers", force: true do |t|
    t.integer  "user_id"
    t.string   "business_name"
    t.string   "industry"
    t.string   "phone"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
    t.date     "formation_year"
    t.text     "additional_information"
  end

  create_table "jobs", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "hours_per_day"
    t.integer  "work_duration"
    t.float    "desired_wage"
    t.float    "max_wage"
    t.boolean  "desired_wage_is_firm", default: false
    t.date     "start_date"
    t.datetime "listing_expires_on"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs_requirements", id: false, force: true do |t|
    t.integer "job_id"
    t.integer "requirement_id"
  end

  add_index "jobs_requirements", ["job_id", "requirement_id"], name: "index_jobs_requirements_on_job_id_and_requirement_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.boolean  "approx_only"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "lat"
    t.float    "lng"
    t.string   "time_zone"
    t.integer  "locateable_id"
    t.string   "locateable_type"
  end

  create_table "photos", force: true do |t|
    t.integer  "photoable_id"
    t.string   "photoable_type"
    t.string   "caption"
    t.boolean  "is_primary"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requirements", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "provider"
    t.string   "uid"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "phone_primary"
    t.text     "phone_secondary"
    t.date     "birth_year"
    t.text     "gender"
    t.boolean  "criminal_convictions"
    t.boolean  "drivers_licence"
    t.boolean  "drivers_licence_class"
    t.boolean  "has_vehicle"
    t.boolean  "car_pool"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
