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

ActiveRecord::Schema.define(version: 20160510072855) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "additional_offers", force: :cascade do |t|
    t.string   "offer_type"
    t.integer  "offer_id"
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_dashboards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "publish",     default: false
  end

  create_table "galleries", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "product_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.decimal  "unit_price",  precision: 12, scale: 3
    t.integer  "quantity"
    t.decimal  "total_price", precision: 12, scale: 3
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.decimal  "subtotal",        precision: 12, scale: 3
    t.decimal  "tax",             precision: 12, scale: 3
    t.decimal  "shipping",        precision: 12, scale: 3
    t.decimal  "total",           precision: 12, scale: 3
    t.integer  "order_status_id"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "user_id"
  end

  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree

  create_table "price_offers", force: :cascade do |t|
    t.decimal  "percent"
    t.decimal  "amount"
    t.string   "gift"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "product_id"
    t.integer  "choice_type"
    t.float    "amount_for_gift"
  end

  create_table "pricings", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "stock_quantity"
    t.float    "mrp_per_unit"
    t.float    "offer_on_mrp"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "product_offers", force: :cascade do |t|
    t.integer  "buy"
    t.integer  "get"
    t.string   "gift"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "product_id"
    t.integer  "choice_type"
    t.float    "buy_for_gift"
  end

  create_table "product_shipping_details", force: :cascade do |t|
    t.boolean  "free_delivery"
    t.integer  "free_kilometers"
    t.float    "charge_per_kilometer"
    t.integer  "product_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "product_shipping_details", ["product_id"], name: "index_product_shipping_details_on_product_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.text     "title"
    t.text     "description"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "delivery_time"
    t.integer  "category_id"
    t.integer  "store_id"
    t.integer  "sub_category_id"
    t.integer  "child_sub_category_id"
    t.boolean  "approve",               default: false
    t.boolean  "status",                default: false
    t.string   "step_path"
    t.string   "key_information"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "shipping_addresses", force: :cascade do |t|
    t.integer  "mobile",     limit: 8
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.integer  "pin_code"
    t.boolean  "status",                                        default: false
    t.integer  "user_id"
    t.decimal  "lat",                  precision: 10, scale: 6
    t.decimal  "lng",                  precision: 10, scale: 6
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
  end

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "country"
    t.string   "state"
    t.string   "city"
    t.integer  "user_id"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.integer  "pin_code"
    t.string   "landmark"
    t.decimal  "lat",                precision: 10, scale: 6
    t.decimal  "lng",                precision: 10, scale: 6
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  create_table "sub_categories", force: :cascade do |t|
    t.text     "title"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "parent_id"
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                      default: ""
    t.string   "encrypted_password",                                         default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                              default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
    t.integer  "mobile",                 limit: 8
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "country"
    t.string   "state"
    t.string   "phone"
    t.integer  "pin_code"
    t.decimal  "lat",                               precision: 10, scale: 6
    t.decimal  "lng",                               precision: 10, scale: 6
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "authentication_token",   limit: 30
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["mobile"], name: "index_users_on_mobile", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "product_shipping_details", "products"
end
