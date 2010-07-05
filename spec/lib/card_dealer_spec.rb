require 'spec_helper'

describe CardDealer do

  it "should respond to self.deal" do
    CardDealer.new.should respond_to :deal
  end
  
  before(:each) do
    config = Configuration.instance
    config.hand_limit = 2
    config.save
  end
    
  describe "selecting game" do
   
    it "should be responsability of a game model? or card?"
   
    it "should work for one game" do
      game = mock_model(SymmetricFunctionGame, :weight => 1)
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game])
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([])
      c = CardDealer.new
      c.should_receive(:rand).with(1).and_return(0)
      c.select_game.should == game
    end
   
    it "should work for two games" do
      game1 = mock_model(SymmetricFunctionGame, :weight => 1)
      game2 = mock_model(SymmetricFunctionGame, :weight => 1)
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game1, game2])
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([])
      c = CardDealer.new
      c.should_receive(:rand).with(2).and_return(1)
      c.select_game.should == game2
    end
   
    it "should work with different weights" do
      game1 = mock_model(SymmetricFunctionGame, :weight => 3, :number_of_players => 2)
      game2 = mock_model(TwoPlayerMatrixGame, :weight => 7, :number_of_players => 2)
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game1])
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game2])
      c = CardDealer.new
      c.should_receive(:rand).with(10).and_return(3)
      c.select_game.should == game2
    end
  end  

  it "should deal for each user" do
    c = CardDealer.new
    game = mock_model(SymmetricFunctionGame, :number_of_players => 3)
    user = mock_model(User)
    c.should_receive(:select_game).and_return(game)
    c.should_receive(:rand).with(3).and_return(2)
    Card.should_receive(:create).with(:user => user, :game => game, :player_number => 3)
    c.deal_for(user)
  end
      
  it "should deal for each user without full hand" do
    users = [mock_model(User, :hand_size => 0),
             mock_model(User, :hand_size => 1),
             mock_model(User, :hand_size => 2),
             mock_model(User, :hand_size => 3)]
    User.should_receive(:find).with(:all).and_return(users)
    c = CardDealer.new
    c.should_receive(:deal_for).with(users[0])
    c.should_receive(:deal_for).with(users[1])
    c.should_not_receive(:deal_for).with(users[3])
    c.should_not_receive(:deal_for).with(users[4])
    c.deal
  end  
end