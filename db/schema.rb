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

ActiveRecord::Schema.define(version: 20180225143001) do

  create_table "developers_projects", id: false, force: true do |t|
    t.integer "developer_id", null: false
    t.integer "project_id",   null: false
  end

  add_index "developers_projects", ["developer_id", "project_id"], name: "index_developers_projects_on_developer_id_and_project_id", using: :btree
  add_index "developers_projects", ["project_id", "developer_id"], name: "index_developers_projects_on_project_id_and_developer_id", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "client"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "project_manager_id"
  end

  create_table "projects_users", id: false, force: true do |t|
    t.integer "project_id", null: false
    t.integer "user_id",    null: false
  end

  create_table "todos", force: true do |t|
    t.string   "task"
    t.integer  "project_id"
    t.integer  "developer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status",       default: "New"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "type",                   default: "ProjectManager"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: "",               null: false
    t.string   "encrypted_password",     default: "",               null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,                null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.integer  "project_manager_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
