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

ActiveRecord::Schema.define(:version => 20130225071748) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "civilizations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "claims", :force => true do |t|
    t.integer  "hunter_id"
    t.integer  "perpetrator_id"
    t.text     "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "claims", ["hunter_id"], :name => "index_claims_on_hunter_id"
  add_index "claims", ["perpetrator_id"], :name => "index_claims_on_perpetrator_id"

  create_table "evidence_links", :force => true do |t|
    t.integer  "evident_id"
    t.string   "link_text"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "evident_type"
  end

  add_index "evidence_links", ["evident_id"], :name => "index_evidence_links_on_report_id"

  create_table "perpetrators", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reports", :force => true do |t|
    t.string   "location"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "active",               :default => true
    t.integer  "perpetrator_id"
    t.integer  "bounty",               :default => 0,    :null => false
    t.integer  "user_id"
    t.integer  "x_coord"
    t.integer  "y_coord"
    t.text     "description"
    t.integer  "civilization_id"
    t.text     "rendered_description"
  end

  add_index "reports", ["civilization_id"], :name => "index_reports_on_civilization_id"
  add_index "reports", ["perpetrator_id"], :name => "index_reports_on_perpetrator_id"

  create_table "rewards", :force => true do |t|
    t.integer  "claim_id"
    t.integer  "report_id"
    t.string   "key"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rewards", ["claim_id"], :name => "index_rewards_on_claim_id"
  add_index "rewards", ["report_id"], :name => "index_rewards_on_report_id"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "minecraft_name"
  end

end
