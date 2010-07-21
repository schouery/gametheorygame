class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :users, :facebook_id, :unique => true
    add_index :symmetric_function_games, :user_id
    add_index :symmetric_function_game_strategies, :game_id
    add_index :cards, :user_id
    add_index :cards, [:game_id, :game_type]
    add_index :cards, [:strategy_id, :strategy_type]
    add_index :cards, :game_result_id
    add_index :cards, :gift_for
    add_index :invitations, :facebook_id
    add_index :two_player_matrix_games, :user_id
    add_index :two_player_matrix_game_strategies, :game_id
    add_index :two_player_matrix_game_payoffs, :game_id
    add_index :two_player_matrix_game_payoffs, :strategy1_id
    add_index :two_player_matrix_game_payoffs, :strategy2_id
    add_index :game_results, [:game_id, :game_type]
    add_index :money_gifts, :facebook_id
    add_index :gift_logs, :user_id, :unique => true
    add_index :game_scores, :user_id
    add_index :game_scores, [:game_id, :game_type]
    add_index :item_types, :item_set_id
    add_index :items, :item_type_id
    add_index :items, :user_id
    add_index :items, :gift_for
    add_index :auctions, :user_id
    add_index :auctions, :item_id, :unique => true
    add_index :auctions, :bidder_id
  end

  def self.down
    remove_index :users, :facebook_id
    remove_index :symmetric_function_games, :user_id
    remove_index :symmetric_function_game_strategies, :game_id
    remove_index :cards, :user_id
    remove_index :cards, [:game_id, :game_type]
    remove_index :cards, [:strategy_id, :strategy_type]
    remove_index :cards, :game_result_id
    remove_index :cards, :gift_for
    remove_index :invitations, :facebook_id
    remove_index :two_player_matrix_games, :user_id
    remove_index :two_player_matrix_game_strategies, :game_id
    remove_index :two_player_matrix_game_payoffs, :game_id
    remove_index :two_player_matrix_game_payoffs, :strategy1_id
    remove_index :two_player_matrix_game_payoffs, :strategy2_id
    remove_index :game_results, [:game_id, :game_type]
    remove_index :money_gifts, :facebook_id
    remove_index :gift_logs, :user_id
    remove_index :game_scores, :user_id
    remove_index :game_scores, [:game_id, :game_type]
    remove_index :item_types, :item_set_id
    remove_index :items, :item_type_id
    remove_index :items, :user_id
    remove_index :items, :gift_for
    remove_index :auctions, :user_id
    remove_index :auctions, :item_id
    remove_index :auctions, :bidder_id    
  end
end
