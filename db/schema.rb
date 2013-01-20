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

ActiveRecord::Schema.define(:version => 20130117202104) do

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
    t.integer  "report_id"
    t.string   "link_text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "evidence_links", ["report_id"], :name => "index_evidence_links_on_report_id"

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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
