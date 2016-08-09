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

ActiveRecord::Schema.define(version: 20160804154804) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artwork_characters", id: false, force: true do |t|
    t.integer  "artwork_id"
    t.integer  "character_id"
    t.boolean  "principal_character", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "artwork_characters", ["artwork_id"], name: "index_artwork_characters_on_artwork_id", using: :btree
  add_index "artwork_characters", ["character_id"], name: "index_artwork_characters_on_character_id", using: :btree

  create_table "artwork_symbols", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artwork_symbols_artworks", force: true do |t|
    t.integer "artwork_id"
    t.integer "artwork_symbol_id"
  end

  create_table "artworks", force: true do |t|
    t.integer  "passage_id"
    t.integer  "author_id"
    t.integer  "scene_id"
    t.integer  "type_id"
    t.integer  "source_id"
    t.integer  "donor_id"
    t.integer  "iconographic_attribute_id"
    t.integer  "phylactery_billboard_id"
    t.integer  "story_type_id"
    t.integer  "school_id"
    t.integer  "origin_city_id"
    t.integer  "actual_city_id"
    t.integer  "origin_country_id"
    t.integer  "actual_country_id"
    t.integer  "place_id"
    t.integer  "category_1_id"
    t.integer  "category_2_id"
    t.integer  "category_3_id"
    t.integer  "category_4_id"
    t.integer  "category_5_id"
    t.boolean  "signed"
    t.string   "title"
    t.string   "activity"
    t.text     "biographic_data"
    t.date     "creation_date"
    t.string   "annotation_date"
    t.text     "synthesis"
    t.text     "biographic_comment"
    t.text     "annotation"
    t.text     "sub_image"
    t.text     "comment"
    t.decimal  "latitude_origin",           precision: 10, scale: 6, default: 0.0
    t.decimal  "latitude_current",          precision: 10, scale: 6, default: 0.0
    t.decimal  "longitude_origin",          precision: 10, scale: 6, default: 0.0
    t.decimal  "longitude_current",         precision: 10, scale: 6, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "sub_image_file_name"
    t.string   "sub_image_content_type"
    t.integer  "sub_image_file_size"
    t.datetime "sub_image_updated_at"
  end

  create_table "artworks_body_gestures", force: true do |t|
    t.integer "artwork_id"
    t.integer "body_gesture_id"
  end

  create_table "artworks_characters", force: true do |t|
    t.integer "artwork_id"
    t.integer "character_id"
  end

  create_table "artworks_descriptions", force: true do |t|
    t.integer "artwork_id"
    t.integer "description_id"
  end

  create_table "artworks_engravings", force: true do |t|
    t.integer "artwork_id"
    t.integer "engraving_id"
  end

  create_table "artworksbk", force: true do |t|
    t.integer  "passage_id"
    t.integer  "author_id"
    t.integer  "scene_id"
    t.integer  "type_id"
    t.integer  "source_id"
    t.integer  "donor_id"
    t.integer  "iconographic_attribute_id"
    t.integer  "phylactery_billboard_id"
    t.integer  "story_type_id"
    t.integer  "school_id"
    t.integer  "origin_city_id"
    t.integer  "actual_city_id"
    t.integer  "origin_country_id"
    t.integer  "actual_country_id"
    t.integer  "place_id"
    t.integer  "category_1_id"
    t.integer  "category_2_id"
    t.integer  "category_3_id"
    t.integer  "category_4_id"
    t.integer  "category_5_id"
    t.boolean  "signed"
    t.string   "title"
    t.string   "activity"
    t.text     "biographic_data"
    t.date     "creation_date"
    t.string   "annotation_date"
    t.text     "synthesis"
    t.text     "biographic_comment"
    t.text     "annotation"
    t.text     "sub_image"
    t.text     "comment"
    t.decimal  "latitude_origin",           precision: 10, scale: 6, default: 0.0
    t.decimal  "latitude_current",          precision: 10, scale: 6, default: 0.0
    t.decimal  "longitude_origin",          precision: 10, scale: 6, default: 0.0
    t.decimal  "longitude_current",         precision: 10, scale: 6, default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "sub_image_file_name"
    t.string   "sub_image_content_type"
    t.integer  "sub_image_file_size"
    t.datetime "sub_image_updated_at"
  end

  create_table "authors", force: true do |t|
    t.string   "name"
    t.string   "lastname"
    t.text     "biography"
    t.text     "activity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "body_gestures", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ancestry"
  end

  create_table "characters", force: true do |t|
    t.string   "name"
    t.text     "biography"
    t.date     "death_date"
    t.date     "beatification_date"
    t.date     "canonization_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "name_spanish"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "descriptions", force: true do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "donors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "engravings", force: true do |t|
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "iconographic_attributes", force: true do |t|
    t.text     "name"
    t.integer  "artwork_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "passages", force: true do |t|
    t.string   "name"
    t.text     "text"
    t.string   "history_type"
    t.string   "source"
    t.integer  "character_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phylactery_billboards", force: true do |t|
    t.text     "name"
    t.integer  "artwork_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "scenes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "story_types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "types", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.boolean  "admin",                  default: false, null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
