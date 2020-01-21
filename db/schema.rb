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

ActiveRecord::Schema.define(version: 2020_01_19_012341) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "flow_instances", force: :cascade do |t|
    t.bigint "responsable_id"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.bigint "flow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flow_id"], name: "index_flow_instances_on_flow_id"
    t.index ["responsable_id"], name: "index_flow_instances_on_responsable_id"
  end

  create_table "flows", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "default_responsable_id"
    t.bigint "created_by_id"
    t.integer "version_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_flows_on_created_by_id"
    t.index ["default_responsable_id"], name: "index_flows_on_default_responsable_id"
  end

  create_table "form_schema_form_input_responses", force: :cascade do |t|
    t.string "value"
    t.integer "form_schema_form_instance_id"
    t.string "input_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_schema_form_inputs", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.boolean "required", null: false
    t.integer "order", null: false
    t.jsonb "schema", default: {}, null: false
    t.string "type", null: false
    t.integer "form_schema_form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_schema_form_instances", force: :cascade do |t|
    t.datetime "finished_at"
    t.integer "form_schema_form_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "form_schema_forms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_blacklist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_blacklist_on_jti"
  end

  create_table "organization_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "organization_id"
    t.bigint "role_id"
    t.boolean "is_owner"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_organization_users_on_organization_id"
    t.index ["role_id"], name: "index_organization_users_on_role_id"
    t.index ["user_id"], name: "index_organization_users_on_user_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "embedded_url"
    t.string "code"
    t.string "random_color"
    t.integer "order", null: false
    t.integer "form_schema_form_id"
    t.bigint "flow_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flow_id"], name: "index_tasks_on_flow_id"
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

  add_foreign_key "flow_instances", "flows"
  add_foreign_key "flow_instances", "users", column: "responsable_id"
  add_foreign_key "flows", "users", column: "created_by_id"
  add_foreign_key "flows", "users", column: "default_responsable_id"
  add_foreign_key "form_schema_form_input_responses", "form_schema_form_instances", name: "form_input_responses_form_instances_indx"
  add_foreign_key "form_schema_form_inputs", "form_schema_forms", name: "form_input_form_indx"
  add_foreign_key "form_schema_form_instances", "form_schema_forms", name: "form_instances_form_indx"
  add_foreign_key "tasks", "flows"
  add_foreign_key "tasks", "form_schema_forms"
end
