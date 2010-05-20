require 'spec_helper'

describe User do
  it { should have_many(:cards) }
  
  it "should respond to payoff" do
    User.new.should respond_to :payoff
  end
  
  it "should calculate the correct payoff" do
    card1 = mock_model(Card, :payoff => 10)
    card2 = mock_model(Card, :payoff => 5)
    card3 = mock_model(Card, :payoff => -2)
    user = User.new
    user.cards = [card1, card2, card3]
    user.payoff.should == 13
  end
  
end
