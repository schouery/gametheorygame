require 'spec_helper'

describe CardDealer do

  it "should respond to self.deal" do
    CardDealer.new.should respond_to :deal
  end
  
  it "should work for one player and one game" do
    game = mock_model(SymmetricFunctionGame)
    user = mock_model(User)
    User.should_receive(:find).with(:all).and_return([user])
    SymmetricFunctionGame.should_receive(:find).with(:all).and_return([game])
    assigns_card_correctly(user, game)
    deal
  end
  
  it "should work for two players and one game" do
    user1 = mock_model(User)
    user2 = mock_model(User)
    User.should_receive(:find).with(:all).and_return([user1, user2])
    game = mock_model(SymmetricFunctionGame)
    SymmetricFunctionGame.should_receive(:find).with(:all).and_return([game])
    assigns_card_correctly(user1, game)
    assigns_card_correctly(user2, game)
    deal
  end

  it "should work for one player and two games" do
    game1 = mock_model(SymmetricFunctionGame)
    game2 = mock_model(SymmetricFunctionGame)
    user = mock_model(User)
    User.should_receive(:find).with(:all).and_return([user])
    SymmetricFunctionGame.should_receive(:find).with(:all).and_return([game1, game2])
    assigns_card_correctly(user, game1)
    deal(2,0)

    User.should_receive(:find).with(:all).and_return([user])
    SymmetricFunctionGame.should_receive(:find).with(:all).and_return([game1, game2])
    assigns_card_correctly(user, game2)
    deal(2,1)
  end

  def deal(game_list_size = 1, result_of_rand = 0)
    c = CardDealer.new
    c.should_receive(:rand).with(game_list_size).any_number_of_times.and_return(result_of_rand)
    c.deal    
  end
  
  def assigns_card_correctly(user, game)
    cards = [mock_model(Card), mock_model(Card)]
    user.should_receive(:cards).and_return(cards)
    card = create_new_card_with(user, game)
    cards.should_receive(:push).with(card)
    user.should_receive(:save)    
  end

  def create_new_card_with(user, game)
    card = mock_model(Card)
    Card.should_receive(:new).and_return(card)
    card.should_receive(:user=).with(user)
    card.should_receive(:game=).with(game)
    card.should_receive(:save)    
    card
  end

end