#Payoff for TwoPlayerMatrixGame, it associates two TwoPlayerMatrixGameStrategy
#(one for each player) with two payoffs (one fot each player)
class TwoPlayerMatrixGamePayoff < ActiveRecord::Base
  validates_presence_of :payoff_player_1, :payoff_player_2
  validates_numericality_of :payoff_player_1, :payoff_player_2,
    :only_integer => true
  belongs_to :game, :class_name => "TwoPlayerMatrixGame"
  belongs_to :strategy1, :class_name => "TwoPlayerMatrixGameStrategy"
  belongs_to :strategy2, :class_name => "TwoPlayerMatrixGameStrategy"

  #A TwoPlayerMatrixGamePayoff is less than another if it's above the other or
  #if it is on the same line then it's on the left.
  def <=>(other_payoff)
    if self.line_position < other_payoff.line_position || 
        (self.line_position == other_payoff.line_position &&
          self.column_position < other_payoff.column_position)
      -1
    else
      1
    end
  end
end
