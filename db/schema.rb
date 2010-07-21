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

ActiveRecord::Schema.define(:version => 20100720160514) do

  create_table "auctions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "end_date"
    t.integer  "reserve_price", :default => 0
    t.integer  "bid",           :default => 0
    t.integer  "bidder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "auctions", ["bidder_id"], :name => "index_auctions_on_bidder_id"
  add_index "auctions", ["item_id"], :name => "index_auctions_on_item_id", :unique => true
  add_index "auctions", ["user_id"], :name => "index_auctions_on_user_id"

  create_table "cards", :force => true do |t|
    t.integer  "user_id"
    t.integer  "payoff"
    t.integer  "game_id"
    t.string   "game_type"
    t.integer  "strategy_id"
    t.string   "strategy_type"
    t.integer  "player_number",               :default => 0
    t.integer  "game_result_id"
    t.integer  "gift_for",       :limit => 8
    t.boolean  "played",                      :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["game_id", "game_type"], :name => "index_cards_on_game_id_and_game_type"
  add_index "cards", ["game_result_id"], :name => "index_cards_on_game_result_id"
  add_index "cards", ["gift_for"], :name => "index_cards_on_gift_for"
  add_index "cards", ["strategy_id", "strategy_type"], :name => "index_cards_on_strategy_id_and_strategy_type"
  add_index "cards", ["user_id"], :name => "index_cards_on_user_id"

  create_table "configurations", :force => true do |t|
    t.integer  "money_gift_value",                 :default => 10
    t.boolean  "full_permissions_to_researchers",  :default => false
    t.boolean  "researcher_can_invite_researcher", :default => false
    t.integer  "starting_money",                   :default => 100
    t.integer  "starting_cards",                   :default => 4
    t.float    "item_probability",                 :default => 0.1
    t.integer  "starting_cards_per_hour",          :default => 1
    t.integer  "starting_hand_limit",              :default => 10
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "game_results", :force => true do |t|
    t.integer  "game_id"
    t.string   "game_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_results", ["game_id", "game_type"], :name => "index_game_results_on_game_id_and_game_type"

  create_table "game_scores", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.string   "game_type"
    t.integer  "score",      :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "game_scores", ["game_id", "game_type"], :name => "index_game_scores_on_game_id_and_game_type"
  add_index "game_scores", ["user_id"], :name => "index_game_scores_on_user_id"

  create_table "invitations", :force => true do |t|
    t.integer  "facebook_id", :limit => 8, :null => false
    t.string   "for"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "invitations", ["facebook_id"], :name => "index_invitations_on_facebook_id"

  create_table "item_sets", :force => true do |t|
    t.string   "name"
    t.string   "bonus_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.integer  "item_set_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "item_types", ["item_set_id"], :name => "index_item_types_on_item_set_id"

  create_table "items", :force => true do |t|
    t.integer  "item_type_id"
    t.integer  "user_id"
    t.boolean  "used",                      :default => false
    t.integer  "gift_for",     :limit => 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["gift_for"], :name => "index_items_on_gift_for"
  add_index "items", ["item_type_id"], :name => "index_items_on_item_type_id"
  add_index "items", ["user_id"], :name => "index_items_on_user_id"

  create_table "money_gifts", :force => true do |t|
    t.integer  "facebook_id", :limit => 8
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "money_gifts", ["facebook_id"], :name => "index_money_gifts_on_facebook_id"

  create_table "symmetric_function_game_strategies", :force => true do |t|
    t.string   "label"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "symmetric_function_game_strategies", ["game_id"], :name => "index_symmetric_function_game_strategies_on_game_id"

  create_table "symmetric_function_games", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "number_of_players"
    t.string   "color"
    t.string   "function"
    t.boolean  "removed",           :default => false
    t.integer  "user_id"
    t.integer  "weight",            :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "symmetric_function_games", ["user_id"], :name => "index_symmetric_function_games_on_user_id"

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

  add_index "two_player_matrix_game_payoffs", ["game_id"], :name => "index_two_player_matrix_game_payoffs_on_game_id"
  add_index "two_player_matrix_game_payoffs", ["strategy1_id"], :name => "index_two_player_matrix_game_payoffs_on_strategy1_id"
  add_index "two_player_matrix_game_payoffs", ["strategy2_id"], :name => "index_two_player_matrix_game_payoffs_on_strategy2_id"

  create_table "two_player_matrix_game_strategies", :force => true do |t|
    t.string   "label"
    t.integer  "player_number"
    t.integer  "game_id"
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "two_player_matrix_game_strategies", ["game_id"], :name => "index_two_player_matrix_game_strategies_on_game_id"

  create_table "two_player_matrix_games", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "color"
    t.boolean  "removed",     :default => false
    t.integer  "user_id"
    t.integer  "weight",      :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "two_player_matrix_games", ["user_id"], :name => "index_two_player_matrix_games_on_user_id"

  create_table "users", :force => true do |t|
    t.integer  "facebook_id",    :limit => 8,                    :null => false
    t.boolean  "admin",                       :default => false
    t.boolean  "researcher",                  :default => false
    t.integer  "money"
    t.integer  "score",                       :default => 0,     :null => false
    t.integer  "cards_per_hour"
    t.integer  "hand_limit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["facebook_id"], :name => "index_users_on_facebook_id", :unique => true

end
