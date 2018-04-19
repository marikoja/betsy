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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 20180419010419) do
=======
ActiveRecord::Schema.define(version: 20180419010200) do
>>>>>>> 4a08633f57493b69b07df1c4c546b63a9d6f9f8a

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

<<<<<<< HEAD
  create_table "categories", force: :cascade do |t|
    t.string "name"
=======
  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.string "status"
>>>>>>> 4a08633f57493b69b07df1c4c546b63a9d6f9f8a
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< HEAD
  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "description"
=======
  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "uid"
    t.string "provider"
>>>>>>> 4a08633f57493b69b07df1c4c546b63a9d6f9f8a
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
