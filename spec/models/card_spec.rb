require 'spec_helper'

describe Card do
  it { should belong_to(:user) }
  it { should belong_to(:game, :polymorphic => true) }
  it { should belong_to(:strategy, :polymorphic => true) }
  it { should have_column(:payoff).type(:integer) }
  it { should have_column(:player_number).type(:integer) }
  it { should belong_to(:game_result)}
  
  it "should know if it was played" do
    c = Card.new
    c.played?.should == false
    c.strategy = mock_model(SymmetricFunctionGameStrategy)
    c.played?.should == true
  end
  
  it "should change the player's money if payoff is positive" do
    mock_user = mock_model(User, :money => 15)
    c = Card.new(:user => mock_user)
    c.payoff = 3
    mock_user.should_receive(:money=).with(18)
    mock_user.should_receive(:save)
    c.save
  end

  it "should change the player's money if payoff is negative" do
    mock_user = mock_model(User, :money => 15)
    c = Card.new(:user => mock_user)
    c.payoff = -3
    mock_user.should_receive(:money=).with(12)
    mock_user.should_receive(:save)
    c.save
  end
  
  it "should change the player's money if payoff is zero" do
    mock_user = mock_model(User, :money => 15)
    c = Card.new(:user => mock_user)
    c.payoff = 0
    mock_user.should_receive(:money=).with(15)
    mock_user.should_receive(:save)
    c.save
  end
  
  it "shouldn't change the player's money if payoff is nil" do
    mock_user = mock_model(User, :money => 15)
    c = Card.new(:user => mock_user)
    c.save
  end
    
end
