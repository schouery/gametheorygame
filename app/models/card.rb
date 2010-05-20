class Card < ActiveRecord::Base
  # attr_reader :payoff
  # attr_accessor :payoff
  belongs_to :user
  belongs_to :symmetric_function_game
  belongs_to :symmetric_function_game_strategy
  has_one :game_play
  
  def play
    self.payoff = self.symmetric_function_game.calculate_payoffs
  end
  
end
