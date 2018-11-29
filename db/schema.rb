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

ActiveRecord::Schema.define(version: 2018_11_29_004814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dog_walkings", force: :cascade do |t|
    t.integer "status"
    t.datetime "schedule_date"
    t.decimal "price"
    t.decimal "duration"
    t.float "latitude"
    t.decimal "longitude"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "dog_walkings_pets", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "dog_walking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["dog_walking_id"], name: "index_dog_walkings_pets_on_dog_walking_id"
    t.index ["pet_id"], name: "index_dog_walkings_pets_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "dog_walkings_pets", "dog_walkings"
  add_foreign_key "dog_walkings_pets", "pets"
end
