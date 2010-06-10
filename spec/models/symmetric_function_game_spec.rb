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
  it { should have_many(:strategies, :class_name => "SymmetricFunctionGameStrategy", :dependent => :destroy, :foreign_key => :game_id)}
  it { should accept_nested_attributes_for :strategies }
  it { should have_many(:cards, :as => :game) }
  it { should have_many(:game_results, :as => :game) }  
  it { should have_column(:weight) }
  it { should validate_numericality_of(:weight).greater_than(0).only_integer }

  before(:each) do
    @game = SymmetricFunctionGame.new
    @strategy1 = mock_model(SymmetricFunctionGameStrategy, :id => 1, :label => "s1")
    @strategy2 = mock_model(SymmetricFunctionGameStrategy, :id => 2, :label => "s2")
    @card1 = mock_model(Card, :game => @game)
    @card2 = mock_model(Card, :game => @game)
  end
  
  describe "generate payoff for players" do
    
    before(:each) do
      @game.number_of_players = 2
      @game.strategies = [@strategy1, @strategy2]
      @game.cards = [@card1, @card2]  
      @game.function = "1"
      @game_result = mock_model(GameResult)
      GameResult.stub(:new => @game_result)
      @game_result.stub!(:cards= => true, :save => true, :game= => true)      
    end
  
    it "should respond to play" do
      SymmetricFunctionGame.new.should respond_to :play
    end
  
    describe "without enough cards" do
      
      it "should prevent the player playing with himself"
  
      it "should do nothing if there is only one card played" do
        @card1.stub(:strategy => @strategy1, :payoff => nil)
        @card2.stub(:strategy => nil, :payoff => nil)
        @game.play
      end

    end
  
    describe "with enough cards" do
      it "should calculate payoff if the same number of cards played and the number of players are equal" do
        [@card1, @card2].each do |card|
          card.stub(:strategy => @strategy1, :payoff => nil)
          card.should_receive(:payoff=).with(1)
          card.should_receive(:save)
        end
        @game.play
      end
  
      it "should ignore cards with payoff" do
        card3 = mock_model(Card, :strategy => @strategy1, :payoff => 10)
        @game.cards = [@card1, @card2, card3]  
        [@card1, @card2].each do |card|
          card.stub(:strategy => @strategy1, :payoff => nil)
          card.should_receive(:payoff=).with(1)
          card.should_receive(:save)
        end
        @game.play
      end
  
      it "should work for other constant functions" do
        [@card1, @card2].each do |card|
          card.stub(:strategy => @strategy1, :payoff => nil)
          card.should_receive(:payoff=).with(2)
          card.should_receive(:save)
        end
        @game.function = "2"
        @game.play
      end
    
      it "should work for other constant functions" do
        [@card1, @card2].each do |card|
          card.stub(:strategy => @strategy1, :payoff => nil)
          card.should_receive(:payoff=).with(2)
          card.should_receive(:save)
        end
        @game.function = "2"
        @game.play
      end
    
      it "should work for function that use the strategy of the player" do
        @card1.stub(:strategy => @strategy1, :payoff => nil)
        @card1.should_receive(:payoff=).with(1)
        @card1.should_receive(:save)
        @card2.stub(:strategy => @strategy2, :payoff => nil)
        @card2.should_receive(:payoff=).with(2)
        @card2.should_receive(:save)
        @game.function = "1*st[0] + 2*st[1]"
        @game.play
      end
  
      it "should work for function that use the number of players who selected the strategy" do
        @card1.stub(:strategy => @strategy1, :payoff => nil)
        @card1.should_receive(:payoff=).with(3)
        @card1.should_receive(:save)
        @card2.stub(:strategy => @strategy2, :payoff => nil)
        @card2.should_receive(:payoff=).with(3)
        @card2.should_receive(:save)
        @game.function = "1*np[0] + 2*np[1]"
        @game.play
      end
    
      it "should work for function that use both st e np" do
        card1 = mock_model(Card, :strategy => @strategy1, :save => true, :game => @game, :payoff => nil)
        card2 = mock_model(Card, :strategy => @strategy1, :save => true, :game => @game, :payoff => nil)
        card3 = mock_model(Card, :strategy => @strategy1, :save => true, :game => @game, :payoff => nil)
        card4 = mock_model(Card, :strategy => @strategy2, :save => true, :game => @game, :payoff => nil)
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
      
      it "should generate a game result" do
        [@card1, @card2].each do |card|
          card.stub(:strategy => @strategy1, :payoff => nil, :payoff= => true, :save => true)
        end        
        result = mock_model(GameResult)
        GameResult.should_receive(:new).and_return(result)
        result.should_receive(:cards=).with([@card1, @card2])
        result.should_receive(:game=).with(@game)
        result.should_receive(:save)
        @game.play
      end

    end

  end

  describe "getting game results" do
    before(:each) do
      @game.number_of_players = 2
      @game.strategies = [@strategy1, @strategy2]
      @card1.stub(:strategy => @strategy1)
      @card2.stub(:strategy => @strategy2)
    end
    
    describe "strategies percentages" do
      it "should calculate results table when there is no game results" do
        @game.strategies_percentages.should == {}
      end
      it "should calculate results table when there is only one game results" do
        @game.game_results = [mock_model(GameResult, :cards => [@card2, @card2])]
        @game.strategies_percentages.should == {@strategy2 => 1}
      end
      it "should calculate results table when there is many games results" do
        @game.game_results = [mock_model(GameResult, :cards => [@card2, @card2]),
                              mock_model(GameResult, :cards => [@card1, @card2]),
                              mock_model(GameResult, :cards => [@card2, @card1]),
                              mock_model(GameResult, :cards => [@card1, @card2])]
        @game.strategies_percentages.should == {@strategy1 => 3.0/8, @strategy2 => 5.0/8}
      end


    end
    
  end
    

end
