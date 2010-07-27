require 'spec_helper'

describe Card do
  it { should belong_to(:user) }
  it { should belong_to(:game, :polymorphic => true) }
  it { should belong_to(:strategy, :polymorphic => true) }
  it { should have_column(:payoff).type(:integer) }
  it { should have_column(:player_number).type(:integer) }
  it { should have_column(:gift_for).type(:integer) }
  it { should belong_to(:game_result)}
  
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
      
  describe "sending as gift" do
    before(:each) do
      @card = Card.new
      @green_game = mock_model(SymmetricFunctionGame, :color => "green")
      @current_user = mock_model(User)
      @card.user = @current_user
      @card.game = @green_game
    end

    it "can be sended if it is a green game, it was not played and the user can send it" do
      @card.can_send_as_gift?(@current_user).should == true
    end
    
    it "can't be sended if the game isn't green" do
      @card.game = mock_model(SymmetricFunctionGame, :color => "red")
      @card.can_send_as_gift?(@current_user).should == false
      @card.game = mock_model(SymmetricFunctionGame, :color => "yellow")
      @card.can_send_as_gift?(@current_user).should == false
    end

    it "can't be sended if the user doesn't won the card" do
      @card.user = mock_model(User)
      @card.can_send_as_gift?(@current_user).should == false
    end
    
    it "can't be sended if it was played" do
      @card.played = true
      @card.can_send_as_gift?(@current_user).should == false
    end
    
    it "should save the changes on sending" do
      @card.send_as_gift(@current_user, 1).should == true
      @card.user.should be_nil
      @card.gift_for.should == 1
    end
    
    it "should not save if there is any error" do
      @card.send_as_gift(mock_model(User), 1).should == false
      @card.user.should == @current_user
      @card.gift_for.should be_nil
    end
  end        
  
  it "should know how to be played" do
    game = mock_model(TwoPlayerMatrixGame)
    user = mock_model(User, :score => 15)
    card = Card.new(:user => user, :game => game)
    card.should_receive(:save)
    user.should_receive(:score=).with(25)
    user.should_receive(:save)
    GameScore.should_receive(:update_game_score).with(game, 10, user)
    card.play(10)
    card.payoff.should == 10
  end
  
end
