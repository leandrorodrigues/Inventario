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

ActiveRecord::Schema.define(version: 20160224183028) do

  create_table "cache_arp", force: :cascade do |t|
    t.integer  "mac_address", limit: 8, null: false
    t.integer  "ip_address",  limit: 4, null: false
    t.datetime "created"
  end

  add_index "cache_arp", ["ip_address"], name: "ip_address_UNIQUE", unique: true, using: :btree
  add_index "cache_arp", ["mac_address"], name: "mac_address_UNIQUE", unique: true, using: :btree

  create_table "cache_ports", force: :cascade do |t|
    t.string  "title",           limit: 100
    t.integer "mac_address",     limit: 8
    t.integer "cache_switch_id", limit: 4,   null: false
  end

  add_index "cache_ports", ["cache_switch_id"], name: "fk_cache_ports_cache_switches1_idx", using: :btree

  create_table "cache_switches", force: :cascade do |t|
    t.string "title", limit: 100
  end

  create_table "connections", force: :cascade do |t|
    t.text    "subject",       limit: 65535
    t.integer "interface0_id", limit: 4,     null: false
    t.integer "interface1_id", limit: 4,     null: false
  end

  add_index "connections", ["interface0_id"], name: "fk_connections_interfaces1_idx", using: :btree
  add_index "connections", ["interface1_id"], name: "fk_connections_interfaces2_idx", using: :btree

  create_table "container_slots", force: :cascade do |t|
    t.string  "title",        limit: 100
    t.integer "container_id", limit: 4,   null: false
    t.integer "device_id",    limit: 4
  end

  add_index "container_slots", ["container_id"], name: "fk_container_slots_containers1_idx", using: :btree
  add_index "container_slots", ["device_id"], name: "index_container_slots_on_device_id", using: :btree

  create_table "container_types", force: :cascade do |t|
    t.string  "title",  limit: 100, null: false
    t.integer "slots",  limit: 4
    t.boolean "nested"
  end

  create_table "containers", force: :cascade do |t|
    t.string  "title",             limit: 100
    t.integer "place_id",          limit: 4,   null: false
    t.integer "item_id",           limit: 4
    t.integer "container_type_id", limit: 4,   null: false
    t.boolean "reverse"
    t.integer "container_id",      limit: 4
  end

  add_index "containers", ["container_id"], name: "fk_containers_containers1_idx", using: :btree
  add_index "containers", ["container_type_id"], name: "fk_containers_container_types1_idx", using: :btree
  add_index "containers", ["item_id"], name: "fk_containers_items1_idx", using: :btree
  add_index "containers", ["place_id"], name: "fk_containers_places_idx", using: :btree

  create_table "device_brands", force: :cascade do |t|
    t.string "title", limit: 100, null: false
  end

  create_table "device_model_params", force: :cascade do |t|
    t.string  "title",           limit: 100, null: false
    t.integer "device_model_id", limit: 4,   null: false
    t.integer "param_id",        limit: 4,   null: false
  end

  add_index "device_model_params", ["device_model_id"], name: "fk_device_model_params_device_models1_idx", using: :btree
  add_index "device_model_params", ["param_id"], name: "fk_device_model_params_params1_idx", using: :btree

  create_table "device_models", force: :cascade do |t|
    t.string  "title",               limit: 100, null: false
    t.integer "device_brand_id",     limit: 4,   null: false
    t.integer "device_type_id",      limit: 4,   null: false
    t.integer "rack_units",          limit: 4
    t.integer "ethernet_interfaces", limit: 4
    t.integer "fiber_interfaces",    limit: 4
    t.string  "stock_unit",          limit: 100
  end

  add_index "device_models", ["device_brand_id"], name: "fk_device_models_device_brands1_idx", using: :btree
  add_index "device_models", ["device_type_id"], name: "fk_device_models_device_types1_idx", using: :btree

  create_table "device_types", force: :cascade do |t|
    t.string "title", limit: 100, null: false
  end

  add_index "device_types", ["title"], name: "title_UNIQUE", unique: true, using: :btree

  create_table "devices", force: :cascade do |t|
    t.string  "title",           limit: 100,                 null: false
    t.integer "item_id",         limit: 4
    t.integer "device_model_id", limit: 4,                   null: false
    t.string  "ip",              limit: 255
    t.string  "host",            limit: 255
    t.string  "description",     limit: 255
    t.boolean "unknown",                     default: false, null: false
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
    t.integer "number",            limit: 4,                    null: false
    t.string  "title",             limit: 100,                  null: false
    t.string  "brand_name",        limit: 255
    t.string  "model_description", limit: 255
    t.string  "serial_number",     limit: 255
    t.date    "warranty_date"
    t.decimal "value",                           precision: 10
    t.decimal "net_value",                       precision: 10
    t.text    "allocation",        limit: 65535
  end

  add_index "items", ["number"], name: "number_UNIQUE", unique: true, using: :btree

  create_table "params", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.string "unit",  limit: 100, null: false
  end

  create_table "places", force: :cascade do |t|
    t.string "title", limit: 100, null: false
  end

  create_table "stock_items", force: :cascade do |t|
    t.string  "title",            limit: 100,                 null: false
    t.integer "item_id",          limit: 4
    t.integer "device_model_id",  limit: 4,                   null: false
    t.integer "container_id",     limit: 4,                   null: false
    t.integer "quantity",         limit: 4
    t.boolean "is_package",                   default: false, null: false
    t.integer "package_quantity", limit: 4
  end

  add_index "stock_items", ["container_id"], name: "fk_stock_item_containers1_idx", using: :btree
  add_index "stock_items", ["device_model_id"], name: "fk_stock_item_device_models1_idx", using: :btree
  add_index "stock_items", ["item_id"], name: "fk_stock_item_items1_idx", using: :btree

  create_table "stock_param_values", force: :cascade do |t|
    t.text    "value",                 limit: 65535, null: false
    t.integer "stock_item_id",         limit: 4,     null: false
    t.integer "device_model_param_id", limit: 4,     null: false
  end

  add_index "stock_param_values", ["device_model_param_id"], name: "fk_stock_param_value_device_model_param1_idx", using: :btree
  add_index "stock_param_values", ["stock_item_id"], name: "fk_stock_param_value_stock_item1_idx", using: :btree

  add_foreign_key "cache_ports", "cache_switches", name: "fk_cache_ports_cache_switches1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "connections", "interfaces", column: "interface0_id", name: "fk_connections_interfaces1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "connections", "interfaces", column: "interface1_id", name: "fk_connections_interfaces2", on_update: :cascade, on_delete: :cascade
  add_foreign_key "container_slots", "containers", name: "fk_container_slots_containers1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "container_slots", "devices"
  add_foreign_key "containers", "container_types", name: "fk_containers_container_types1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "containers", "containers", name: "fk_containers_containers1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "containers", "items", name: "fk_containers_items1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "containers", "places", name: "fk_containers_places", on_update: :cascade, on_delete: :cascade
  add_foreign_key "device_model_params", "device_models", name: "fk_device_model_params_device_models1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "device_model_params", "params", name: "fk_device_model_params_params1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "device_models", "device_brands", name: "fk_device_models_device_brands1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "device_models", "device_types", name: "fk_device_models_device_types1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "devices", "device_models", name: "fk_devices_device_models1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "devices", "items", name: "fk_devices_items1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "interfaces", "devices", name: "fk_interfaces_devices1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "interfaces", "interface_types", name: "fk_interfaces_interface_types1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "stock_items", "containers", name: "fk_stock_item_containers1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "stock_items", "device_models", name: "fk_stock_item_device_models1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "stock_items", "items", name: "fk_stock_item_items1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "stock_param_values", "device_model_params", name: "fk_stock_param_value_device_model_param1", on_update: :cascade, on_delete: :cascade
  add_foreign_key "stock_param_values", "stock_items", name: "fk_stock_param_value_stock_item1", on_update: :cascade, on_delete: :cascade
end
