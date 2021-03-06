# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_05_18_012830) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id", null: false
  end

  create_table "product_parts", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_product_parts_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "unit_price", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_deleted", default: false, null: false
    t.string "targetted_customers"
  end

  create_table "products_staffs", id: :bigint, default: -> { "nextval('staff_logs_id_seq'::regclass)" }, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "product_id"
    t.integer "user_id"
    t.datetime "log_time", null: false
    t.string "operation", null: false
  end

  create_table "sale_transaction_line_items", force: :cascade do |t|
    t.decimal "subtotal", precision: 8, scale: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "sale_transaction_id"
    t.integer "product_id"
    t.integer "quantity", default: 1, null: false
    t.integer "cart_id", null: false
    t.boolean "is_sold", default: false, null: false
  end

  create_table "sale_transactions", force: :cascade do |t|
    t.integer "total_line_item"
    t.integer "total_quantity"
    t.decimal "total_amount", precision: 8, scale: 2
    t.date "transaction_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "username"
    t.integer "access_right_enum"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "carts", "users", name: "carts_user_id_fkey", on_delete: :cascade
  add_foreign_key "product_parts", "products"
  add_foreign_key "products_staffs", "products", name: "staff_logs_product_id_fkey"
  add_foreign_key "products_staffs", "users", name: "staff_logs_staff_id_fkey"
  add_foreign_key "sale_transaction_line_items", "carts", name: "sale_transaction_line_items_cart_id_fkey", on_delete: :cascade
  add_foreign_key "sale_transaction_line_items", "products", name: "sale_transaction_line_items_product_id_fkey"
  add_foreign_key "sale_transaction_line_items", "sale_transactions", name: "sale_transaction_line_items_sale_transaction_id_fkey"
  add_foreign_key "sale_transactions", "users", name: "sale_transactions_user_id_fkey"
end
