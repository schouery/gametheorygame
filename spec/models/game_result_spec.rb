require 'spec_helper'

describe GameResult do
  it { should belong_to(:game, :polymorphic => true) }
  it { should have_many(:cards) }
  
  it "knows how to sort the cards" do
    cards = [mock_model(Card, :player_number => 3), mock_model(Card, :player_number => 1),
             mock_model(Card, :player_number => 5), mock_model(Card, :player_number => 2), mock_model(Card, :player_number => 4)]
    game_result = GameResult.new(:cards => cards)
    game_result.sorted_cards.should == [cards[1], cards[3], cards[0], cards[4], cards[2]]  
  end
end
