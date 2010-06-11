require 'spec_helper'

describe Card do
  it { should belong_to(:user) }
  it { should belong_to(:game, :polymorphic => true) }
  it { should belong_to(:strategy, :polymorphic => true) }
  it { should have_column(:payoff).type(:integer) }
  it { should have_column(:player_number).type(:integer) }
  it { should have_column(:gift_for).type(:integer) }
  it { should belong_to(:game_result)}
  
  
  it "should know if is possible to send it" do
    c = Card.new
    c.game = mock_model(SymmetricFunctionGame, :color => "green")
    c.can_send?.should == true
    c.strategy = mock_model(SymmetricFunctionGameStrategy)
    c.can_send?.should == false
    c.game = mock_model(SymmetricFunctionGame, :color => "red")
    c.strategy = nil
    c.can_send?.should == false
    c.strategy = mock_model(SymmetricFunctionGameStrategy)
    c.can_send?.should == false
  end
  
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
      
  # if !card.can_send_gift?(current_user)
  # if !card.send_gift(current_user, params[:ids[0]].to_i)
  #   flash[:notice] = card.gift_error
  # end
  
  
  describe "sending as gift" do
    before(:each) do
      @card = Card.new
      @green_game = mock_model(SymmetricFunctionGame, :color => "green")
      @gift_log = mock_model(GiftLog)
      @current_user = mock_model(User, :gift_log => @gift_log)
      @gift_log.stub(:maximum_gifts_today).with(:card).and_return(1)
      @card.user = @current_user
      @card.game = @green_game
      @card.strategy = nil
    end

    it "can be sended if it is a green game, it was not played and the user can send it" do
      @card.can_send_as_gift?(@current_user).should == true
      @card.gift_error.should == ""
    end
    
    it "can't be sended if it doesn't have a game" do
      @card.game = nil
      @card.can_send_as_gift?(@current_user).should == false
      @card.gift_error.should == "You can't send this card!"
    end
    
    it "can't be sended if the game isn't green" do
      @card.game = mock_model(SymmetricFunctionGame, :color => "red")
      @card.can_send_as_gift?(@current_user).should == false
      @card.gift_error.should == "You can't send this card!"
      @card.game = mock_model(SymmetricFunctionGame, :color => "yellow")
      @card.can_send_as_gift?(@current_user).should == false
      @card.gift_error.should == "You can't send this card!"
    end

    it "can't be sended if the user doesn't won the card" do
      @card.user = mock_model(User)
      @card.can_send_as_gift?(@current_user).should == false
      @card.gift_error.should == "You can't send this card!"
    end
    
    it "can't be sended if the user can't send more cards today" do
      @gift_log.stub(:maximum_gifts_today).with(:card).and_return(0)
      @card.can_send_as_gift?(@current_user).should == false
      @card.gift_error.should == "You can't send more cards today."
    end
    
    it "can't be sended if it was played" do
      @card.strategy = mock_model(SymmetricFunctionGameStrategy)
      @card.can_send_as_gift?(@current_user).should == false
      @card.gift_error.should == "You can't send this card!"
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
      @card.gift_error.should == "You can't send this card!"
    end
    
  end    
    
    
end
