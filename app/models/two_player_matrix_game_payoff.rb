class TwoPlayerMatrixGamePayoff < ActiveRecord::Base
  attr_accessor :line_position, :column_position
  validates_presence_of :payoff_player_1, :payoff_player_2
  validates_numericality_of :payoff_player_1, :payoff_player_2, :only_integer => true
  belongs_to :game, :class_name => "TwoPlayerMatrixGame"
  belongs_to :strategy1, :class_name => "TwoPlayerMatrixGameStrategy"
  belongs_to :strategy2, :class_name => "TwoPlayerMatrixGameStrategy"
end
