class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :symmetric_function_game
  belongs_to :symmetric_function_game_strategy
  has_one :game_play    
end
