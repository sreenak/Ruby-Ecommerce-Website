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

ActiveRecord::Schema.define(version: 20150718102549) do

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
    t.integer  "brocade_id", limit: 4
    t.integer  "part_id",    limit: 4
    t.string   "image",      limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "brocade_parts", ["brocade_id"], name: "index_brocade_parts_on_brocade_id", using: :btree
  add_index "brocade_parts", ["part_id"], name: "index_brocade_parts_on_part_id", using: :btree

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

  create_table "discount_coupons", force: :cascade do |t|
    t.string   "code",                       limit: 255
    t.decimal  "amount",                                 precision: 9, scale: 2, default: 0.0, null: false
    t.integer  "applies_as",                 limit: 2,                           default: 0,   null: false
    t.integer  "maximum_usages",             limit: 4
    t.integer  "minimum_order_price_paisas", limit: 4,                           default: 0,   null: false
    t.integer  "status",                     limit: 2,                           default: 0,   null: false
    t.datetime "created_at",                                                                   null: false
    t.datetime "updated_at",                                                                   null: false
  end

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

  create_table "embellishment_parts", force: :cascade do |t|
    t.integer  "embellishment_id", limit: 4
    t.integer  "part_id",          limit: 4
    t.string   "image",            limit: 255, default: "", null: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "embellishment_parts", ["embellishment_id"], name: "index_embellishment_parts_on_embellishment_id", using: :btree
  add_index "embellishment_parts", ["part_id"], name: "index_embellishment_parts_on_part_id", using: :btree

  create_table "embellishments", force: :cascade do |t|
    t.string   "name",       limit: 255, default: "", null: false
    t.string   "image",      limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "fabric_colors", force: :cascade do |t|
    t.string   "name",       limit: 255, default: "", null: false
    t.integer  "fabric_id",  limit: 4
    t.string   "swatch",     limit: 255, default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "fabric_colors", ["fabric_id"], name: "index_fabric_colors_on_fabric_id", using: :btree

  create_table "fabric_colors_parts_groups", id: false, force: :cascade do |t|
    t.integer "part_group_id",   limit: 4, null: false
    t.integer "fabric_color_id", limit: 4, null: false
  end

  add_index "fabric_colors_parts_groups", ["part_group_id", "fabric_color_id"], name: "part_groups_fabric_colors", using: :btree

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

  add_index "parts", ["parts_group_id"], name: "index_parts_on_part_group_id", using: :btree

  create_table "parts_groups", force: :cascade do |t|
    t.string   "name",         limit: 255, default: "", null: false
    t.integer  "dress_id",     limit: 4
    t.string   "type",         limit: 255, default: "", null: false
    t.string   "svg_group_id", limit: 255, default: "", null: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "parts_groups", ["dress_id"], name: "index_parts_groups_on_dress_id", using: :btree

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
  end

  add_index "products", ["dress_id"], name: "index_products_on_dress_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id", limit: 4, null: false
    t.integer "user_id", limit: 4, null: false
  end

  add_index "roles_users", ["user_id", "role_id"], name: "index_roles_users_on_user_id_and_role_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255, default: "", null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "image",                  limit: 255
    t.string   "mobile",                 limit: 255
    t.date     "date_of_birth"
    t.integer  "gender",                 limit: 1
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
  add_foreign_key "dresses", "categories"
  add_foreign_key "embellishment_parts", "embellishments"
  add_foreign_key "embellishment_parts", "parts"
  add_foreign_key "fabric_colors", "fabrics"
  add_foreign_key "parts", "parts_groups"
  add_foreign_key "parts_groups", "dresses"
  add_foreign_key "product_images", "products"
  add_foreign_key "products", "dresses"
end
