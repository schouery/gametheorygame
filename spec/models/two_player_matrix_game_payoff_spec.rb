require 'spec_helper'

describe TwoPlayerMatrixGamePayoff do
  it { should validate_presence_of(:payoff_player_1) }
  it { should validate_presence_of(:payoff_player_2) }
  it { should validate_numericality_of(:payoff_player_1).only_integer }
  it { should validate_numericality_of(:payoff_player_2).only_integer }
  it { should belong_to(:game, :class_name => "TwoPlayerMatrixGame")}
  it { should belong_to(:strategy1, :class_name => "TwoPlayerMatrixGameStrategy")}
  it { should belong_to(:strategy2, :class_name => "TwoPlayerMatrixGameStrategy")}
  
  describe "comparing" do
    def payoff_in(line_position, column_position)
      TwoPlayerMatrixGamePayoff.new(:line_position => line_position, :column_position => column_position)
    end
    
    it "should be less than a payoff below it" do
      (payoff_in(0,0) <=> payoff_in(1,0)).should < 0
      (payoff_in(1,2) <=> payoff_in(2,0)).should < 0
      (payoff_in(2,0) <=> payoff_in(4,2)).should < 0
    end
    it "should be less than a payoff on the same line but in the right of it" do
      (payoff_in(0,0) <=> payoff_in(0,1)).should < 0
      (payoff_in(1,2) <=> payoff_in(1,4)).should < 0
    end
    it "should be greater than a payoff that is above it" do
      (payoff_in(1,0) <=> payoff_in(0,0)).should > 0
      (payoff_in(2,0) <=> payoff_in(1,2)).should > 0
      (payoff_in(4,2) <=> payoff_in(2,0)).should > 0
    end
    it "should be grater than a payoff on the same line but on the left of it" do
      (payoff_in(0,1) <=> payoff_in(0,0)).should > 0
      (payoff_in(1,4) <=> payoff_in(1,2)).should > 0
    end
  end
end
