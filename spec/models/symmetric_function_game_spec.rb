require 'spec_helper'

describe SymmetricFunctionGame do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:function) }
  it { should validate_presence_of(:number_of_players) }
  it { should validate_presence_of(:color) }
  it { should validate_numericality_of(:number_of_players).greater_than(0).only_integer }
  it { should validate_inclusion_of(:color, :in => ["red", "green", "yellow"]) }
  it "should validate that function is a valid ruby function"
  it { should have_many(:strategies, :class_name => "SymmetricFunctionGameStrategy", :dependent => :destroy)}
  it { should accept_nested_attributes_for :strategies }
  it { should have_many(:cards) }
  
  describe "generate payoff for players" do
  
    before(:each) do
      @game = SymmetricFunctionGame.new
      @game.number_of_players = 2
      @strategy1 = mock_model(SymmetricFunctionGameStrategy, :id => 1)
      @strategy2 = mock_model(SymmetricFunctionGameStrategy, :id => 2)
      @card1 = mock_model(Card, :symmetric_function_game => @game)
      @card2 = mock_model(Card, :symmetric_function_game => @game)
      @game.strategies = [@strategy1, @strategy2]
      @game.cards = [@card1, @card2]  
      @game.function = "1"
    end
  
    it "should prevent the player playing with himself"
  
    it "should respond to play" do
      SymmetricFunctionGame.new.should respond_to :play
    end
  
    it "should do nothing if there is only one card played" do
      @card1.stub(:symmetric_function_game_strategy => @strategy1)
      @card2.stub(:symmetric_function_game_strategy => nil)
      @game.play
    end
  
    it "should calculate payoff if the same number of cards played and the number of players are equal" do
      [@card1, @card2].each do |card|
        card.stub(:symmetric_function_game_strategy => @strategy1)
        card.should_receive(:payoff=).with(1)
        card.should_receive(:save)
      end
      @game.play
    end

    it "should work for other constant functions" do
      [@card1, @card2].each do |card|
        card.stub(:symmetric_function_game_strategy => @strategy1)
        card.should_receive(:payoff=).with(2)
        card.should_receive(:save)
      end
      @game.function = "2"
      @game.play
    end
    
    it "should work for other constant functions" do
      [@card1, @card2].each do |card|
        card.stub(:symmetric_function_game_strategy => @strategy1)
        card.should_receive(:payoff=).with(2)
        card.should_receive(:save)
      end
      @game.function = "2"
      @game.play
    end
    
    it "should work for function that use the strategy of the player" do
      @card1.stub(:symmetric_function_game_strategy => @strategy1)
      @card1.should_receive(:payoff=).with(1)
      @card1.should_receive(:save)
      @card2.stub(:symmetric_function_game_strategy => @strategy2)
      @card2.should_receive(:payoff=).with(2)
      @card2.should_receive(:save)
      @game.function = "1*st[0] + 2*st[1]"
      @game.play
    end

    it "should work for function that use the number of players who selected the strategy" do
      @card1.stub(:symmetric_function_game_strategy => @strategy1)
      @card1.should_receive(:payoff=).with(3)
      @card1.should_receive(:save)
      @card2.stub(:symmetric_function_game_strategy => @strategy2)
      @card2.should_receive(:payoff=).with(3)
      @card2.should_receive(:save)
      @game.function = "1*np[0] + 2*np[1]"
      @game.play
    end
    
    it "should work for function that use both st e np" do
      card1 = mock_model(Card, :symmetric_function_game_strategy => @strategy1, :save => true, :symmetric_function_game => @game)
      card2 = mock_model(Card, :symmetric_function_game_strategy => @strategy1, :save => true, :symmetric_function_game => @game)
      card3 = mock_model(Card, :symmetric_function_game_strategy => @strategy1, :save => true, :symmetric_function_game => @game)
      card4 = mock_model(Card, :symmetric_function_game_strategy => @strategy2, :save => true, :symmetric_function_game => @game)
      game = SymmetricFunctionGame.new
      game.number_of_players = 4
      game.strategies = [@strategy1, @strategy2]
      game.cards = [card1, card2, card3, card4]
      [card1, card2, card3].each do |card|
        card.should_receive(:payoff=).with(3)
      end
      card4.should_receive(:payoff=).with(6)
      game.function = "np[0] + 3*st[1]"
      game.play
    end
  end

end
