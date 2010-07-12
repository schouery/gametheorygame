require 'spec_helper'

describe CardDealer do

  it "should respond to self.deal" do
    CardDealer.new.should respond_to :deal
  end
      
  describe "selecting game" do
   
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
    c.game_for(user)
  end
      
  it "should deal for each user without full hand" do
    users = [mock_model(User, :hand_size => 0, :hand_limit => 1, :cards_per_hour => 1),
             mock_model(User, :hand_size => 1, :hand_limit => 2, :cards_per_hour => 1),
             mock_model(User, :hand_size => 2, :hand_limit => 2, :cards_per_hour => 1),
             mock_model(User, :hand_size => 3, :hand_limit => 2, :cards_per_hour => 1)]
    User.should_receive(:find).with(:all).and_return(users)
    c = CardDealer.new
    c.should_receive(:deal_for).with(users[0])
    c.should_receive(:deal_for).with(users[1])
    c.should_not_receive(:deal_for).with(users[3])
    c.should_not_receive(:deal_for).with(users[4])
    c.deal
  end
  
  it "should deal according to cards_per_hour" do
    user = mock_model(User, :hand_size => 0, :hand_limit => 2, :cards_per_hour => 2)
    User.should_receive(:find).with(:all).and_return([user])
    c = CardDealer.new
    c.should_receive(:deal_for).with(user).twice
    c.deal
  end  
  
  it "should create a item for a user" do
    c = CardDealer.new
    user = mock_model(User)
    item_types = [mock_model(ItemType),mock_model(ItemType),mock_model(ItemType)]
    ItemType.should_receive(:all).and_return(item_types)
    c.should_receive(:rand).with(3).and_return(1)
    Item.should_receive(:create).with(:user => user, :item_type => item_types[1])
    c.item_for(user)
  end
  
  describe "dealing for a user" do
    it "should create a item if the rand is less than item probability" do
      c = CardDealer.new
      user = mock_model(User)
      Configuration.stub(:[]).with(:item_probability).and_return(0.1)
      c.should_receive(:rand).and_return(0.05)
      c.should_receive(:item_for).with(user)
      c.deal_for(user)
    end
    it "should create a card if the rand is more than item probability" do
      c = CardDealer.new
      user = mock_model(User)
      Configuration.stub(:[]).with(:item_probability).and_return(0.1)
      c.should_receive(:rand).and_return(0.2)
      c.should_receive(:game_for).with(user)
      c.deal_for(user)
    end
  end  
end