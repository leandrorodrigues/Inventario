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

ActiveRecord::Schema.define(version: 0) do

  create_table "connections", force: :cascade do |t|
    t.text    "subject",        limit: 65535
    t.integer "interface0_id",  limit: 4,     null: false
    t.integer "interfaces1_id", limit: 4,     null: false
  end

  add_index "connections", ["interface0_id"], name: "fk_connections_interfaces1_idx", using: :btree
  add_index "connections", ["interfaces1_id"], name: "fk_connections_interfaces2_idx", using: :btree

  create_table "container_slots", force: :cascade do |t|
    t.string  "title",        limit: 100
    t.integer "container_id", limit: 4,   null: false
  end

  add_index "container_slots", ["container_id"], name: "fk_container_slots_containers1_idx", using: :btree

  create_table "container_slots_items", force: :cascade do |t|
    t.integer "item_id",           limit: 4, null: false
    t.integer "container_slot_id", limit: 4, null: false
  end

  add_index "container_slots_items", ["container_slot_id"], name: "fk_items_container_slots_container_slots1_idx", using: :btree
  add_index "container_slots_items", ["item_id"], name: "fk_items_container_slots_items1_idx", using: :btree

  create_table "container_types", force: :cascade do |t|
    t.string  "title",  limit: 100, null: false
    t.integer "slots",  limit: 4
    t.boolean "nested"
  end

  create_table "containers", force: :cascade do |t|
    t.string  "title",             limit: 100
    t.integer "place_id",          limit: 4,   null: false
    t.integer "item_id",           limit: 4,   null: false
    t.integer "container_type_id", limit: 4,   null: false
  end

  add_index "containers", ["container_type_id"], name: "fk_containers_container_types1_idx", using: :btree
  add_index "containers", ["item_id"], name: "fk_containers_items1_idx", using: :btree
  add_index "containers", ["place_id"], name: "fk_containers_places_idx", using: :btree

  create_table "device_brands", force: :cascade do |t|
    t.string "title", limit: 100, null: false
  end

  create_table "device_models", force: :cascade do |t|
    t.string  "title",               limit: 100, null: false
    t.integer "device_brand_id",     limit: 4,   null: false
    t.integer "device_type_id",      limit: 4,   null: false
    t.integer "rack_units",          limit: 4
    t.integer "ethernet_interfaces", limit: 4
  end

  add_index "device_models", ["device_brand_id"], name: "fk_device_models_device_brands1_idx", using: :btree
  add_index "device_models", ["device_type_id"], name: "fk_device_models_device_types1_idx", using: :btree

  create_table "device_types", force: :cascade do |t|
    t.string "title", limit: 100, null: false
  end

  add_index "device_types", ["title"], name: "title_UNIQUE", unique: true, using: :btree

  create_table "devices", force: :cascade do |t|
    t.string  "title",           limit: 100, null: false
    t.integer "item_id",         limit: 4,   null: false
    t.integer "device_model_id", limit: 4,   null: false
  end

  add_index "devices", ["device_model_id"], name: "fk_devices_device_models1_idx", using: :btree
  add_index "devices", ["item_id"], name: "fk_devices_item_idx", using: :btree

  create_table "interface_types", force: :cascade do |t|
    t.string "title", limit: 100, null: false
  end

  add_index "interface_types", ["title"], name: "title_UNIQUE", unique: true, using: :btree

  create_table "interfaces", force: :cascade do |t|
    t.string  "title",             limit: 100, null: false
    t.integer "device_id",         limit: 4,   null: false
    t.string  "address",           limit: 100
    t.integer "interface_type_id", limit: 4,   null: false
    t.string  "mac",               limit: 100
  end

  add_index "interfaces", ["device_id"], name: "fk_interfaces_devices1_idx", using: :btree
  add_index "interfaces", ["interface_type_id"], name: "fk_interfaces_interface_types1_idx", using: :btree

  create_table "items", force: :cascade do |t|
    t.integer "number", limit: 4,   null: false
    t.string  "title",  limit: 100, null: false
  end

  add_index "items", ["number"], name: "number_UNIQUE", unique: true, using: :btree

  create_table "places", force: :cascade do |t|
    t.string "title", limit: 100, null: false
  end

  add_foreign_key "connections", "interfaces", column: "interface0_id", name: "fk_connections_interfaces1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "connections", "interfaces", column: "interfaces1_id", name: "fk_connections_interfaces2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "container_slots", "containers", name: "fk_container_slots_containers1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "container_slots_items", "container_slots", name: "fk_items_container_slots_container_slots1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "container_slots_items", "items", name: "fk_items_container_slots_items1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "containers", "container_types", name: "fk_containers_container_types1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "containers", "items", name: "fk_containers_items1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "containers", "places", name: "fk_containers_places", on_update: :cascade, on_delete: :cascade
  add_foreign_key "device_models", "device_brands", name: "fk_device_models_device_brands1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "device_models", "device_types", name: "fk_device_models_device_types1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "devices", "device_models", name: "fk_devices_device_models1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "devices", "items", name: "fk_devices_items1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "interfaces", "devices", name: "fk_interfaces_devices1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "interfaces", "interface_types", name: "fk_interfaces_interface_types1", on_update: :cascade, on_delete: :cascade
end
