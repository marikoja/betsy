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
ActiveRecord::Schema.define(version: 20180419155031) do
=======
ActiveRecord::Schema.define(version: 20180419035721) do

>>>>>>> 4bf146231c28d98be4243c3e170ffa434f683db8

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

<<<<<<< HEAD
  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

=======
>>>>>>> 4bf146231c28d98be4243c3e170ffa434f683db8
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "order_id"
    t.integer "product_id"
    t.integer "quantity"
<<<<<<< HEAD
=======
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: :cascade do |t|
    t.integer "user_id"
    t.string "status"
>>>>>>> 4bf146231c28d98be4243c3e170ffa434f683db8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

<<<<<<< HEAD
  create_table "products_categories", force: :cascade do |t|
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "product_id"
    t.integer "rating"
    t.string "text_review"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

=======
>>>>>>> 4bf146231c28d98be4243c3e170ffa434f683db8
  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.integer "uid"
    t.string "provider"
<<<<<<< HEAD
=======
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "product_id"
    t.integer "rating"
    t.string "text_review"
>>>>>>> 4bf146231c28d98be4243c3e170ffa434f683db8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
