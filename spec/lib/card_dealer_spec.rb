require 'spec_helper'

describe CardDealer do

  it "should respond to self.deal" do
    CardDealer.new.should respond_to :deal
  end
  
  describe "without full hands" do  
    before(:each) do
      config = Configuration.instance
      config.hand_limit = 10
      config.save
    end
    
    it "should work for one player and one game" do
      game = mock_model(SymmetricFunctionGame, :weight => 1)
      user = mock_model(User, :cards => [])
      User.should_receive(:find).with(:all).and_return([user])
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game])
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([])
      assigns_card_correctly(user, game)
      deal
    end
  
    it "should work for two players and one game" do
      user1 = mock_model(User, :cards => [])
      user2 = mock_model(User, :cards => [])
      User.should_receive(:find).with(:all).and_return([user1, user2])
      game = mock_model(SymmetricFunctionGame, :weight => 1)
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game])
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([])
      assigns_card_correctly(user1, game)
      assigns_card_correctly(user2, game)
      deal
    end

    it "should work for one player and two games" do
      game1 = mock_model(SymmetricFunctionGame, :weight => 1)
      game2 = mock_model(SymmetricFunctionGame, :weight => 1)
      user = mock_model(User, :cards => [])
      User.should_receive(:find).with(:all).and_return([user])
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game1, game2])
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([])
      assigns_card_correctly(user, game1)
      deal(2,0)

      User.should_receive(:find).with(:all).and_return([user])
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game1, game2])
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([])
      assigns_card_correctly(user, game2)
      deal(2,1)
    end
  
  
    it "should work for two players and two games with diffent weights" do
      game1 = mock_model(SymmetricFunctionGame, :weight => 3)
      game2 = mock_model(TwoPlayerMatrixGame, :weight => 7)
      user1 = mock_model(User, :cards => [])
      user2 = mock_model(User, :cards => [])
      User.should_receive(:find).with(:all).and_return([user1, user2])
    
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game1])
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game2])

      assigns_card_correctly(user1, game2)
      assigns_card_correctly(user2, game1)
      c = CardDealer.new
      c.should_receive(:rand).with(10).and_return(3)
      c.should_receive(:rand).with(10).and_return(0)
      c.deal
    end
  end

  describe "without full hands" do  
    before(:each) do
      config = Configuration.instance
      config.hand_limit = 2
      config.save
    end
    
    it "should give cards only to players that doesn't have a full hand" do
      user_with_full_hand = mock_model(User, :cards => [mock_model(Card), mock_model(Card)])
      user_without_full_hand = mock_model(User, :cards => [])
      User.should_receive(:find).with(:all).and_return([user_with_full_hand, user_without_full_hand])
      game1 = mock_model(SymmetricFunctionGame, :weight => 1)
      game2 = mock_model(TwoPlayerMatrixGame, :weight => 1)
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game1])
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => false}).and_return([game2])
      assigns_card_correctly(user_without_full_hand, game1)
      deal(2)          
    end
  end

  def deal(weight_sum = 1, result_of_rand = 0)
    c = CardDealer.new
    c.should_receive(:rand).with(weight_sum).any_number_of_times.and_return(result_of_rand)
    c.deal
  end

  def assigns_card_correctly(user, game)
    Card.should_receive(:create).with(:user => user, :game => game)
  end
end