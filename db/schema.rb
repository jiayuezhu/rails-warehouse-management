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

ActiveRecord::Schema.define(version: 2018_08_29_211443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.string "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "descriptions", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "detail_id"
    t.string "parameter"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["detail_id"], name: "index_descriptions_on_detail_id"
    t.index ["product_id"], name: "index_descriptions_on_product_id"
  end

  create_table "details", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lists", force: :cascade do |t|
    t.string "buyer"
    t.string "seller"
    t.string "notes"
    t.float "sub_total"
    t.float "tax"
    t.float "price_total"
    t.bigint "bill_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bill_id"], name: "index_lists_on_bill_id"
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
    t.integer "retail_sole"
    t.integer "wholesale_sold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wholesales", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "list_id"
    t.integer "quantity"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_wholesales_on_list_id"
    t.index ["product_id"], name: "index_wholesales_on_product_id"
  end

  add_foreign_key "descriptions", "details"
  add_foreign_key "descriptions", "products"
  add_foreign_key "wholesales", "lists", on_delete: :cascade
  add_foreign_key "wholesales", "products"
end
