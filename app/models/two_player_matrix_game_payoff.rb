class TwoPlayerMatrixGamePayoff < ActiveRecord::Base
  validates_presence_of :payoff_player_1, :payoff_player_2
  validates_numericality_of :payoff_player_1, :payoff_player_2, :only_integer => true
  belongs_to :game, :class_name => "TwoPlayerMatrixGame"
  belongs_to :strategy1, :class_name => "TwoPlayerMatrixGameStrategy"
  belongs_to :strategy2, :class_name => "TwoPlayerMatrixGameStrategy"
  
  def <=>(other_payoff)
    if self.line_position < other_payoff.line_position || 
        (self.line_position == other_payoff.line_position && self.column_position < other_payoff.column_position)
      -1
    else
      1
    end
  end
end
