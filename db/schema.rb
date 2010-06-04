# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100526130516) do

  create_table "cards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "payoff"
    t.integer  "game_id"
    t.string   "game_type"
    t.integer  "strategy_id"
    t.string   "strategy_type"
    t.integer  "player_number",  :default => 0
    t.integer  "game_result_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_results", :force => true do |t|
    t.integer  "game_id"
    t.string   "game_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "invitations", :force => true do |t|
    t.integer  "facebook_id", :limit => 20, :null => false
    t.string   "for"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "symmetric_function_game_strategies", :force => true do |t|
    t.string   "label"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "symmetric_function_games", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "number_of_players"
    t.string   "color"
    t.string   "function"
    t.boolean  "removed",           :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "two_player_matrix_game_payoffs", :force => true do |t|
    t.integer  "game_id"
    t.integer  "strategy1_id"
    t.integer  "strategy2_id"
    t.integer  "payoff_player_1"
    t.integer  "payoff_player_2"
    t.integer  "line_position"
    t.integer  "column_position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "two_player_matrix_game_strategies", :force => true do |t|
    t.string   "label"
    t.integer  "player_number"
    t.integer  "game_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "two_player_matrix_games", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "color"
    t.boolean  "removed",     :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.integer  "facebook_id", :limit => 20,                    :null => false
    t.boolean  "admin",                     :default => false
    t.boolean  "researcher",                :default => false
    t.integer  "money",                     :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
