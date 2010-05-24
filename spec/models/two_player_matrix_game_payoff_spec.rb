require 'spec_helper'

describe TwoPlayerMatrixGamePayoff do
  it { should validate_presence_of(:payoff_player_1) }
  it { should validate_presence_of(:payoff_player_2) }
  it { should validate_numericality_of(:payoff_player_1).only_integer }
  it { should validate_numericality_of(:payoff_player_2).only_integer }
  it { should belong_to(:game, :class_name => "TwoPlayerMatrixGame")}
  it { should belong_to(:strategy1, :class_name => "TwoPlayerMatrixGameStrategy")}
  it { should belong_to(:strategy2, :class_name => "TwoPlayerMatrixGameStrategy")}
end
