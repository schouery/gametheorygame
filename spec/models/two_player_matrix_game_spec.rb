require 'spec_helper'

describe TwoPlayerMatrixGame do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:color) }
  it { should validate_inclusion_of(:color, :in => ["red", "green", "yellow"]) }
  it { should have_many(:strategies, :class_name => "TwoPlayerMatrixGameStrategy", :dependent => :destroy, :foreign_key => :game_id)}
  it { should accept_nested_attributes_for :strategies }
  it { should accept_nested_attributes_for :payoffs }
  it { should have_many(:cards, :as => :game) }
  it { should have_many(:game_results, :as => :game) }
  it { should have_many(:payoffs, :class_name => "TwoPlayerMatrixGamePayoff", :dependent => :destroy, :foreign_key => :game_id)}
  it { should have_column(:weight) }
  it { should validate_numericality_of(:weight).greater_than(0).only_integer }
  
  before(:each) do
    @game = TwoPlayerMatrixGame.new
    @strategies_player_1 = [mock_model(TwoPlayerMatrixGameStrategy, :player_number => 1, :id=>1),
                            mock_model(TwoPlayerMatrixGameStrategy, :player_number => 1, :id=>2)]
    @strategies_player_2 = [mock_model(TwoPlayerMatrixGameStrategy, :player_number => 2, :id=>3),
                            mock_model(TwoPlayerMatrixGameStrategy, :player_number => 2, :id=>4)]
    @payoffs = [mock_model(TwoPlayerMatrixGamePayoff, :strategy1 => @strategies_player_1[0], :strategy2 => @strategies_player_2[0]),
                mock_model(TwoPlayerMatrixGamePayoff, :strategy1 => @strategies_player_1[0], :strategy2 => @strategies_player_2[1]),
                mock_model(TwoPlayerMatrixGamePayoff, :strategy1 => @strategies_player_1[1], :strategy2 => @strategies_player_2[0]),
                mock_model(TwoPlayerMatrixGamePayoff, :strategy1 => @strategies_player_1[1], :strategy2 => @strategies_player_2[1])]                          
  end
  
  describe "getting strategies and payoffs" do
    before(:each) do
      @game.strategies = @strategies_player_1 + @strategies_player_2
      @game.payoffs = @payoffs
    end
    
    it "should respond to columns_strategies" do
      @game.should respond_to :columns_strategies
    end
    
    it "should respond to lines_strategies" do
      @game.should respond_to :lines_strategies
    end
    
    it "should map player one on line strategies" do
      @game.lines_strategies.should == @strategies_player_1
    end
    
    it "should map player two on columns strategies" do
      @game.columns_strategies.should == @strategies_player_2
    end
    
    it "should respond to payoff_matrix" do
      @game.should respond_to :payoff_matrix
    end
    
    it "should map the payoffs correctly" do
      @game.payoff_matrix.should == [@payoffs[0..1],@payoffs[2..3]]
    end
  end
  
  it "should be able to associate payoffs to strategies by position" do
    @strategies_player_1.each_with_index {|strategy, i| strategy.stub(:number => i)}
    @strategies_player_2.each_with_index {|strategy, i| strategy.stub(:number => i)}
    payoffs = [mock_model(TwoPlayerMatrixGamePayoff,  :strategy1 => nil, :strategy2 => nil),
                mock_model(TwoPlayerMatrixGamePayoff, :strategy1 => nil, :strategy2 => nil),
                mock_model(TwoPlayerMatrixGamePayoff, :strategy1 => nil, :strategy2 => nil),
                mock_model(TwoPlayerMatrixGamePayoff, :strategy1 => nil, :strategy2 => nil)]
    (0..1).each do |i|
      (0..1).each do |j|
        payoffs[i*2+j].stub(:line_position => i, :column_position => j)
      end
    end
    
    @game.strategies = @strategies_player_1 + @strategies_player_2#[@strategy1,@strategy2,@strategy3,@strategy4]
    @game.payoffs = payoffs#[@payoff1, @payoff2, @payoff3, @payoff4]
    @strategies_player_1.each_with_index do |st1, i|
      @strategies_player_2.each_with_index do |st2, j|
        payoffs[i*2 + j].should_receive(:strategy1=).with(st1)
        payoffs[i*2 + j].should_receive(:strategy2=).with(st2)
      end
    end
    @game.associate_payoffs
  end
  
  describe 'initial setup for strategies and payoffs' do
    
    it "should have correctly assigned strategies after calling setup_strategies" do
      @game.should respond_to :setup_strategies
      @game.setup_strategies
      @game.strategies.size.should == 4
      @game.strategies.each_with_index do |strategy, i|
        strategy.player_number.should == 1 + (i/2)
      end
    end
    
    it "should have correctly assigned payoffs related to each strategy" do
      @game.strategies = @strategies_player_1 + @strategies_player_2
      @game.should respond_to :setup_payoffs
      @game.setup_payoffs
      @strategies_player_1.each_with_index do |st1, i|
        @strategies_player_2.each_with_index do |st2, j|
          @game.payoffs[i*2+j].strategy1.should == st1
          @game.payoffs[i*2+j].strategy2.should == st2
        end
      end
    end

    it "should call setup_strategies and setup_payoffs on initial_setup" do
      @game.should respond_to :initial_setup
      @game.should_receive(:setup_strategies)
      @game.should_receive(:setup_payoffs)
      @game.initial_setup
    end    
  end
  
  describe "play" do
    before(:each) do
      @cards = [mock_model(Card, :game => @game, :strategy => nil), 
                mock_model(Card, :game => @game, :strategy => nil)]
    end

    describe "without enough cards" do
      it "shouldn't generate payoffs if there aren't two players that played" do
        @game.cards = @cards[0..0]
        #This is going to fail if save is called in @card1 or @card2
        @game.play
      end
      
      it "shouldn't generate payoffs if only player one played" do
        @cards.each do |card|
          card.stub(:player_number => 1, :strategy => @strategies_player_1[0])
        end
        #This is going to fail if save is called in @card1 or @card2
        @game.play
      end
      
      it "shouldn't generate payoffs if only player two played" do
        @cards.each do |card|
          card.stub(:player_number => 2, :strategy => @strategies_player_2[0])
        end
        #This is going to fail if save is called in @card1 or @card2
        @game.play
      end
    end

    describe "with enough cards" do
      before(:each) do
        @cards[0].stub(:player_number => 1, :strategy => @strategies_player_1[0], :payoff => nil)
        @cards[1].stub(:player_number => 2, :strategy => @strategies_player_2[0], :payoff => nil)
        @game.cards = @cards
        @payoffs[0].stub(:payoff_player_1 => 0, :payoff_player_2 => 1)
        @game.payoffs.stub(:find => @payoffs[0])        
        @game_result = mock_model(GameResult)
        
      end
            
      it "should assign payoff correctly" do
        @cards.each_with_index do |card, i|
          card.should_receive(:payoff=).with(i)
          card.should_receive(:save)
          user = mock_model(User, :score => 0)
          card.should_receive(:user).and_return(user)
          user.should_receive(:score=).with(i)
          user.should_receive(:save)
        end
        @game_result.stub(:cards= => true, :save => true, :game= => true)
        GameResult.stub(:new => @game_result)
        @game.play
      end
      
      it "should create a GameResult correctly" do
        @cards[0].stub(:payoff= => true, :save => true)
        @cards[1].stub(:payoff= => true, :save => true)
        GameResult.should_receive(:new).and_return(@game_result)
        @game_result.should_receive(:cards=).with(@cards)
        @game_result.should_receive(:game=).with(@game)
        @game_result.should_receive(:save)
        @game.stub(:update_card => true)
        @game.play
      end

    end
    
  end
  
  describe "getting strategies" do

    before(:each) do
      @game.strategies = @strategies_player_1 + @strategies_player_2
    end
     
    def simulate_results(freq)
      card1 = mock_model(Card, :strategy => @strategies_player_1[0])
      card2 = mock_model(Card, :strategy => @strategies_player_1[1])
      card3 = mock_model(Card, :strategy => @strategies_player_2[0])
      card4 = mock_model(Card, :strategy => @strategies_player_2[1])
      [[mock_model(GameResult, :cards => [card1, card3])]*freq[0],
      [mock_model(GameResult, :cards => [card1, card4])]*freq[1],
      [mock_model(GameResult, :cards => [card2, card3])]*freq[2],
      [mock_model(GameResult, :cards => [card2, card4])]*freq[3]].flatten
    end
    
    it "should respond to results_matrix" do
      @game.should respond_to :results_matrix
    end
    
    it "should calculate the correctly frequencies when there is no game results" do
      @game.game_results = []
      @game.results_matrix.should == [[0,0],[0,0]]
    end
    
    it "should calculate the correctly frquencies when there is only one game result" do
      @game.game_results = simulate_results([1,0,0,0])
      @game.results_matrix.should == [[1,0],[0,0]]
    end
    
    it "should calculate the correctly frequencies when there are many results" do
      @game.game_results = simulate_results([2,6,4,8])
      results_matrix = @game.results_matrix
      (results_matrix[0][0] - 0.1).should < 0.001
      (results_matrix[0][1] - 0.3).should < 0.001
      (results_matrix[1][0] - 0.2).should < 0.001
      (results_matrix[1][1] - 0.4).should < 0.001
    end
    
    
  end
  
end