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

ActiveRecord::Schema.define(:version => 20120328042710) do

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
    t.string   "number",        :null => false
    t.date     "start_date",    :null => false
    t.date     "end_date"
    t.integer  "vehicle_id"
    t.integer  "work_order_id", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "created_by",    :null => false
    t.integer  "employee_id",   :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "number",                       :null => false
    t.string   "name",                         :null => false
    t.string   "email",                        :null => false
    t.string   "phone"
    t.string   "billing_name"
    t.string   "billing_address",              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city",                         :null => false
    t.string   "state",           :limit => 2, :null => false
    t.string   "zip",             :limit => 5, :null => false
  end

  create_table "departments", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "number",                                    :null => false
    t.string   "name",                                      :null => false
    t.string   "phone",                                     :null => false
    t.boolean  "admin",                  :default => false, :null => false
    t.integer  "department_id",                             :null => false
    t.integer  "supervisor_id"
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
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

  add_index "employees", ["email"], :name => "index_employees_on_email", :unique => true
  add_index "employees", ["reset_password_token"], :name => "index_employees_on_reset_password_token", :unique => true

  create_table "labor_assignments", :id => false, :force => true do |t|
    t.integer  "task_id",                                      :null => false
    t.integer  "employee_id",                                  :null => false
    t.integer  "assignment_id",                                :null => false
    t.decimal  "rate",          :precision => 10, :scale => 0, :null => false
    t.string   "rate_type",                                    :null => false
    t.integer  "est_hours",                                    :null => false
    t.integer  "used_hours"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "locations", :force => true do |t|
    t.string   "name",                     :null => false
    t.string   "address",                  :null => false
    t.integer  "client_id",                :null => false
    t.integer  "proposal_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "city",                     :null => false
    t.string   "state",       :limit => 2, :null => false
    t.string   "zip",         :limit => 5, :null => false
  end

  create_table "material_assignments", :id => false, :force => true do |t|
    t.integer  "task_id",       :null => false
    t.integer  "material_id",   :null => false
    t.integer  "assignment_id", :null => false
    t.integer  "qty_sent",      :null => false
    t.integer  "qty_used"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "materials", :force => true do |t|
    t.string   "name",                                      :null => false
    t.decimal  "unit_cost",  :precision => 10, :scale => 0, :null => false
    t.integer  "quantity",                                  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proposals", :force => true do |t|
    t.string  "number",        :null => false
    t.string  "status",        :null => false
    t.date    "decision_date"
    t.string  "est_method",    :null => false
    t.string  "customer_type", :null => false
    t.integer "client_id"
    t.integer "employee_id",   :null => false
    t.date    "created_at"
    t.date    "updated_at"
  end

  create_table "tasks", :force => true do |t|
    t.string   "title",                                         :null => false
    t.string   "status"
    t.integer  "sqft",                                          :null => false
    t.decimal  "price_per_sqft", :precision => 10, :scale => 2, :null => false
    t.integer  "est_hours"
    t.date     "date_completed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id",                                   :null => false
  end

  create_table "vehicles", :force => true do |t|
    t.string   "make",                           :null => false
    t.string   "model",                          :null => false
    t.string   "year",                           :null => false
    t.boolean  "checked_out", :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_orders", :force => true do |t|
    t.text     "notes"
    t.date     "date_required", :null => false
    t.integer  "employee_id",   :null => false
    t.integer  "proposal_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number",        :null => false
    t.string   "level",         :null => false
    t.integer  "location_id",   :null => false
  end

end
