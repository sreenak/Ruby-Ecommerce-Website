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

ActiveRecord::Schema.define(version: 20150826164009) do

  create_table "addresses", force: :cascade do |t|
    t.string   "type",             limit: 255, default: "", null: false
    t.integer  "addressable_id",   limit: 4
    t.string   "addressable_type", limit: 255
    t.string   "name",             limit: 255, default: "", null: false
    t.string   "address_1",        limit: 255, default: "", null: false
    t.string   "address_2",        limit: 255
    t.string   "country",          limit: 255, default: "", null: false
    t.string   "state",            limit: 255
    t.string   "city",             limit: 255, default: "", null: false
    t.string   "postal_code",      limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id", using: :btree

  create_table "auth_identities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.string   "token",      limit: 255
    t.datetime "expires_on"
    t.text     "params",     limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "auth_identities", ["user_id"], name: "index_auth_identities_on_user_id", using: :btree

  create_table "brocade_parts", force: :cascade do |t|
    t.integer  "brocade_id",   limit: 4
    t.integer  "part_id",      limit: 4
    t.string   "image",        limit: 255, default: "",    null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "price_paisas", limit: 4,   default: 0,     null: false
    t.string   "currency",     limit: 255, default: "INR", null: false
  end

  add_index "brocade_parts", ["brocade_id"], name: "index_brocade_parts_on_brocade_id", using: :btree
  add_index "brocade_parts", ["part_id"], name: "index_brocade_parts_on_part_id", using: :btree

  create_table "brocade_parts_embellishments", id: false, force: :cascade do |t|
    t.integer "brocade_part_id",  limit: 4, null: false
    t.integer "embellishment_id", limit: 4, null: false
  end

  create_table "brocades", force: :cascade do |t|
    t.string   "name",       limit: 255, default: "", null: false
    t.string   "swatch",     limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",        limit: 255,   default: "", null: false
    t.string   "slug",        limit: 255,   default: "", null: false
    t.text     "description", limit: 65535
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",    limit: 255, null: false
    t.string   "data_content_type", limit: 255
    t.integer  "data_file_size",    limit: 4
    t.integer  "assetable_id",      limit: 4
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width",             limit: 4
    t.integer  "height",            limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "colors", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "image",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "colors_products", id: false, force: :cascade do |t|
    t.integer "product_id", limit: 4, null: false
    t.integer "color_id",   limit: 4, null: false
  end

  create_table "custom_sizes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "size",       limit: 255
    t.string   "unit",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "custom_sizes_dresses", id: false, force: :cascade do |t|
    t.integer "dress_id",       limit: 4, null: false
    t.integer "custom_size_id", limit: 4, null: false
  end

  create_table "customised_dresses", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "dress_id",   limit: 4
    t.text     "details",    limit: 4294967295
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "image",      limit: 255
  end

  add_index "customised_dresses", ["dress_id"], name: "index_customised_dresses_on_dress_id", using: :btree
  add_index "customised_dresses", ["user_id"], name: "index_customised_dresses_on_user_id", using: :btree

  create_table "discount_coupons", force: :cascade do |t|
    t.string   "code",                       limit: 255
    t.decimal  "amount",                                 precision: 9, scale: 2, default: 0.0,   null: false
    t.integer  "applies_as",                 limit: 2,                           default: 0,     null: false
    t.integer  "maximum_usages",             limit: 4
    t.integer  "minimum_order_price_paisas", limit: 4,                           default: 0,     null: false
    t.boolean  "active",                     limit: 1,                           default: false, null: false
    t.datetime "created_at",                                                                     null: false
    t.datetime "updated_at",                                                                     null: false
    t.string   "currency",                   limit: 255,                         default: "INR", null: false
    t.integer  "usage_count",                limit: 4,                           default: 0,     null: false
  end

  create_table "dress_line_item_options", force: :cascade do |t|
    t.integer  "line_item_id",     limit: 4
    t.integer  "standard_size_id", limit: 4
    t.text     "details",          limit: 65535
    t.string   "angle_0",          limit: 255,   default: "", null: false
    t.string   "angle_90",         limit: 255
    t.string   "angle_180",        limit: 255
    t.string   "angle_270",        limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "dress_line_item_options", ["line_item_id"], name: "index_dress_line_item_options_on_line_item_id", using: :btree
  add_index "dress_line_item_options", ["standard_size_id"], name: "index_dress_line_item_options_on_standard_size_id", using: :btree

  create_table "dresses", force: :cascade do |t|
    t.string   "name",              limit: 255, default: "",    null: false
    t.string   "slug",              limit: 255, default: "",    null: false
    t.integer  "category_id",       limit: 4
    t.string   "sku",               limit: 255, default: "",    null: false
    t.integer  "base_price_paisas", limit: 4,   default: 0,     null: false
    t.string   "currency",          limit: 255, default: "INR", null: false
    t.string   "angle_0",           limit: 255, default: "",    null: false
    t.string   "angle_90",          limit: 255
    t.string   "angle_180",         limit: 255
    t.string   "angle_270",         limit: 255
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.string   "sketch",            limit: 255, default: "",    null: false
  end

  add_index "dresses", ["category_id"], name: "index_dresses_on_category_id", using: :btree

  create_table "dresses_standard_sizes", id: false, force: :cascade do |t|
    t.integer "dress_id",         limit: 4, null: false
    t.integer "standard_size_id", limit: 4, null: false
  end

  create_table "embellishment_parts", force: :cascade do |t|
    t.integer  "embellishment_id", limit: 4
    t.integer  "part_id",          limit: 4
    t.string   "image",            limit: 255, default: "",    null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "price_paisas",     limit: 4,   default: 0,     null: false
    t.string   "currency",         limit: 255, default: "INR", null: false
  end

  add_index "embellishment_parts", ["embellishment_id"], name: "index_embellishment_parts_on_embellishment_id", using: :btree
  add_index "embellishment_parts", ["part_id"], name: "index_embellishment_parts_on_part_id", using: :btree

  create_table "embellishments", force: :cascade do |t|
    t.string   "name",       limit: 255, default: "", null: false
    t.string   "image",      limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "embellishments_fabric_group_colors", id: false, force: :cascade do |t|
    t.integer "fabric_group_color_id", limit: 4, null: false
    t.integer "embellishment_id",      limit: 4, null: false
  end

  create_table "fabric_colors", force: :cascade do |t|
    t.string   "name",       limit: 255, default: "", null: false
    t.integer  "fabric_id",  limit: 4
    t.string   "swatch",     limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "fabric_colors", ["fabric_id"], name: "index_fabric_colors_on_fabric_id", using: :btree

  create_table "fabric_group_colors", force: :cascade do |t|
    t.integer "fabric_parts_group_id", limit: 4,                   null: false
    t.integer "fabric_color_id",       limit: 4,                   null: false
    t.integer "price_paisas",          limit: 4,   default: 0,     null: false
    t.string  "currency",              limit: 255, default: "INR", null: false
  end

  add_index "fabric_group_colors", ["fabric_parts_group_id", "fabric_color_id"], name: "part_groups_fabric_colors", using: :btree

  create_table "fabrics", force: :cascade do |t|
    t.string   "name",       limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "gift_card_usages", force: :cascade do |t|
    t.integer  "gift_card_id",  limit: 4
    t.integer  "amount_paisas", limit: 4,   default: 0,  null: false
    t.string   "currency",      limit: 255, default: "", null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "gift_card_usages", ["gift_card_id"], name: "index_gift_card_usages_on_gift_card_id", using: :btree

  create_table "gift_cards", force: :cascade do |t|
    t.string   "code",             limit: 255,   default: "",    null: false
    t.integer  "status",           limit: 2
    t.string   "ordered_by",       limit: 255,   default: "",    null: false
    t.string   "ordered_for",      limit: 255,   default: "",    null: false
    t.text     "message",          limit: 65535
    t.integer  "amount_paisas",    limit: 4,     default: 0,     null: false
    t.integer  "remaining_paisas", limit: 4,     default: 0,     null: false
    t.string   "currency",         limit: 255,   default: "INR", null: false
    t.string   "deliver_to",       limit: 255,   default: "",    null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "type",             limit: 255
    t.string   "email",            limit: 255
  end

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "likes", ["product_id"], name: "index_likes_on_product_id", using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.string   "title",              limit: 255, default: "",    null: false
    t.integer  "order_id",           limit: 4
    t.integer  "line_itemable_id",   limit: 4
    t.string   "line_itemable_type", limit: 255
    t.integer  "quantity",           limit: 4,   default: 0,     null: false
    t.integer  "amount_paisas",      limit: 4,   default: 0,     null: false
    t.string   "currency",           limit: 255, default: "INR", null: false
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
  end

  add_index "line_items", ["line_itemable_type", "line_itemable_id"], name: "index_line_items_on_line_itemable_type_and_line_itemable_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree

  create_table "order_statuses", force: :cascade do |t|
    t.integer  "order_id",    limit: 4
    t.string   "status_type", limit: 10
    t.date     "date"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "order_statuses", ["order_id"], name: "index_order_statuses_on_order_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id",      limit: 4
    t.integer  "status",       limit: 2,   default: 0,     null: false
    t.integer  "total_paisas", limit: 4,   default: 0,     null: false
    t.string   "currency",     limit: 255, default: "INR", null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",      limit: 255,   null: false
    t.string   "slug",       limit: 255,   null: false
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "pages", ["slug"], name: "index_pages_on_slug", unique: true, using: :btree

  create_table "parts", force: :cascade do |t|
    t.string   "name",           limit: 255, default: "", null: false
    t.integer  "parts_group_id", limit: 4
    t.string   "svg_path_id",    limit: 255, default: "", null: false
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "parts", ["parts_group_id"], name: "index_parts_on_parts_group_id", using: :btree

  create_table "parts_groups", force: :cascade do |t|
    t.string   "name",         limit: 255, default: "", null: false
    t.integer  "dress_id",     limit: 4
    t.string   "type",         limit: 255, default: "", null: false
    t.string   "svg_group_id", limit: 255, default: "", null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "parts_groups", ["dress_id"], name: "index_parts_groups_on_dress_id", using: :btree

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id",      limit: 4
    t.string   "method",        limit: 255
    t.integer  "amount_paisas", limit: 4
    t.string   "currency",      limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title",      limit: 255,   default: "",    null: false
    t.string   "slug",       limit: 255,   default: "",    null: false
    t.string   "image",      limit: 255,   default: "",    null: false
    t.text     "body",       limit: 65535
    t.boolean  "featured",   limit: 1,     default: false, null: false
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
  end

  create_table "product_images", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.string   "image",      limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "product_images", ["product_id"], name: "index_product_images_on_product_id", using: :btree

  create_table "product_line_item_options", force: :cascade do |t|
    t.integer  "line_item_id",     limit: 4
    t.integer  "standard_size_id", limit: 4
    t.boolean  "is_gift",          limit: 1,   default: false, null: false
    t.string   "message",          limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  add_index "product_line_item_options", ["line_item_id"], name: "index_product_line_item_options_on_line_item_id", using: :btree
  add_index "product_line_item_options", ["standard_size_id"], name: "index_product_line_item_options_on_standard_size_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",         limit: 255,   default: "",    null: false
    t.string   "slug",         limit: 255,   default: "",    null: false
    t.string   "sku",          limit: 255,   default: "",    null: false
    t.integer  "price_paisas", limit: 4,     default: 0,     null: false
    t.string   "currency",     limit: 255,   default: "INR", null: false
    t.string   "image",        limit: 255,   default: "",    null: false
    t.boolean  "featured",     limit: 1,     default: false, null: false
    t.integer  "dress_id",     limit: 4
    t.text     "description",  limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "category_id",  limit: 4
    t.text     "material",     limit: 65535
  end

  add_index "products", ["category_id"], name: "index_products_on_category_id", using: :btree
  add_index "products", ["dress_id"], name: "index_products_on_dress_id", using: :btree

  create_table "products_standard_sizes", id: false, force: :cascade do |t|
    t.integer "product_id",       limit: 4, null: false
    t.integer "standard_size_id", limit: 4, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "product_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.string   "message",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.boolean  "active",     limit: 1
  end

  add_index "reviews", ["product_id"], name: "index_reviews_on_product_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4, null: false
    t.integer "user_id", limit: 4, null: false
  end

  add_index "roles_users", ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", using: :btree

  create_table "shipments", force: :cascade do |t|
    t.integer  "order_id",    limit: 4
    t.string   "tracking_id", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "status",      limit: 2
  end

  add_index "shipments", ["order_id"], name: "index_shipments_on_order_id", using: :btree

  create_table "shipping_services", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "standard_sizes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "styles", force: :cascade do |t|
    t.integer  "styles_group_id", limit: 4
    t.string   "name",            limit: 255
    t.string   "image",           limit: 255
    t.string   "svg_path_id",     limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "styles", ["styles_group_id"], name: "index_styles_on_styles_group_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "image",                  limit: 255
    t.string   "mobile",                 limit: 255
    t.date     "date_of_birth"
    t.integer  "gender",                 limit: 2
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "auth_identities", "users"
  add_foreign_key "brocade_parts", "brocades"
  add_foreign_key "brocade_parts", "parts"
  add_foreign_key "customised_dresses", "dresses"
  add_foreign_key "customised_dresses", "users"
  add_foreign_key "dress_line_item_options", "line_items"
  add_foreign_key "dress_line_item_options", "standard_sizes"
  add_foreign_key "dresses", "categories"
  add_foreign_key "embellishment_parts", "embellishments"
  add_foreign_key "embellishment_parts", "parts"
  add_foreign_key "fabric_colors", "fabrics"
  add_foreign_key "gift_card_usages", "gift_cards"
  add_foreign_key "likes", "products", on_delete: :cascade
  add_foreign_key "likes", "users", on_delete: :cascade
  add_foreign_key "line_items", "orders"
  add_foreign_key "order_statuses", "orders"
  add_foreign_key "orders", "users"
  add_foreign_key "parts", "parts_groups"
  add_foreign_key "parts_groups", "dresses"
  add_foreign_key "payments", "orders"
  add_foreign_key "product_images", "products"
  add_foreign_key "product_line_item_options", "line_items"
  add_foreign_key "product_line_item_options", "standard_sizes"
  add_foreign_key "products", "categories"
  add_foreign_key "products", "dresses"
  add_foreign_key "reviews", "products"
  add_foreign_key "reviews", "users"
  add_foreign_key "shipments", "orders"
end
