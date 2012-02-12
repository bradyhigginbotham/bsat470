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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120212033830) do

  create_table "accounts", :force => true do |t|
    t.string   "full_name",                              :null => false
    t.string   "email",                  :default => "", :null => false
    t.string   "role",                                   :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accounts", ["email"], :name => "index_accounts_on_email", :unique => true
  add_index "accounts", ["reset_password_token"], :name => "index_accounts_on_reset_password_token", :unique => true

  create_table "active_admin_comments", :force => true do |t|
    t.integer  "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "assignments", :force => true do |t|
    t.string   "assignment_num",     :null => false
    t.date     "finish_date"
    t.integer  "vehicle_id"
    t.date     "authorization_date"
    t.integer  "work_order_id",      :null => false
    t.integer  "employee_id",        :null => false
    t.string   "authorized_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "client_num",      :null => false
    t.string   "full_name",       :null => false
    t.string   "email",           :null => false
    t.string   "billing_name"
    t.string   "billing_address", :null => false
    t.datetime "created_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "full_name"
    t.string   "email"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string  "name",        :null => false
    t.string  "address",     :null => false
    t.integer "client_id",   :null => false
    t.integer "proposal_id", :null => false
  end

  create_table "proposals", :force => true do |t|
    t.string   "proposal_num",                         :null => false
    t.string   "status",        :default => "Pending", :null => false
    t.string   "customer_type"
    t.string   "est_method"
    t.integer  "location_num"
    t.date     "decision_date"
    t.datetime "created_at"
    t.integer  "client_id",                            :null => false
    t.integer  "account_id",                           :null => false
  end

  create_table "tasks", :force => true do |t|
    t.string  "label",         :null => false
    t.integer "sq_ft",         :null => false
    t.integer "est_hours",     :null => false
    t.date    "date_complete"
    t.integer "location_id",   :null => false
  end

  create_table "work_orders", :force => true do |t|
    t.string   "order_num",                            :null => false
    t.string   "status",        :default => "Pending", :null => false
    t.date     "date_required",                        :null => false
    t.string   "notes"
    t.datetime "created_at"
    t.integer  "account_id",                           :null => false
    t.string   "proposal_id",                          :null => false
  end

end
