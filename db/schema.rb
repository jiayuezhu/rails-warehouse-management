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

ActiveRecord::Schema.define(version: 2018_09_08_043927) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string "notes"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bills_on_user_id"
  end

  create_table "buyers", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "phone_number"
    t.string "wechat_id"
    t.string "company"
    t.string "notes"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.boolean "is_buyer"
    t.string "website"
    t.index ["user_id"], name: "index_buyers_on_user_id"
  end

  create_table "descriptions", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "detail_id"
    t.bigint "user_id"
    t.string "parameter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["detail_id"], name: "index_descriptions_on_detail_id"
    t.index ["product_id"], name: "index_descriptions_on_product_id"
    t.index ["user_id"], name: "index_descriptions_on_user_id"
  end

  create_table "details", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_details_on_user_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "notes"
    t.float "sub_total"
    t.float "paid"
    t.float "owed"
    t.boolean "is_finished"
    t.float "tax"
    t.float "price_total"
    t.bigint "bill_id"
    t.bigint "buyer_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_lists_on_bill_id"
    t.index ["buyer_id"], name: "index_lists_on_buyer_id"
    t.index ["user_id"], name: "index_lists_on_user_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "model"
    t.string "category"
    t.string "color"
    t.integer "storage"
    t.string "brand"
    t.float "purchase_price"
    t.float "retail_labeled_price"
    t.float "wholesale_labeled_price"
    t.integer "retail_sold"
    t.integer "wholesale_sold"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_products_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wholesales", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "list_id"
    t.bigint "user_id"
    t.integer "quantity"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_wholesales_on_list_id"
    t.index ["product_id"], name: "index_wholesales_on_product_id"
    t.index ["user_id"], name: "index_wholesales_on_user_id"
  end

  add_foreign_key "bills", "users"
  add_foreign_key "buyers", "users"
  add_foreign_key "descriptions", "details"
  add_foreign_key "descriptions", "products"
  add_foreign_key "descriptions", "users"
  add_foreign_key "details", "users"
  add_foreign_key "lists", "users"
  add_foreign_key "products", "users"
  add_foreign_key "wholesales", "lists", on_delete: :cascade
  add_foreign_key "wholesales", "products"
  add_foreign_key "wholesales", "users"
end
