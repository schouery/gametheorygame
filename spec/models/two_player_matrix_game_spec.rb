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
  it { should have_many(:payoffs, :class_name => "TwoPlayerMatrixGamePayoff", :dependent => :destroy, :foreign_key => :game_id)}
  
  describe "getting strategies and payoffs" do
    before(:each) do
      @strategy1 = stub_model(TwoPlayerMatrixGameStrategy, :player_number => 1, :id=>1)
      @strategy2 = stub_model(TwoPlayerMatrixGameStrategy, :player_number => 1, :id=>2)
      @strategy3 = stub_model(TwoPlayerMatrixGameStrategy, :player_number => 2, :id=>3)
      @strategy4 = stub_model(TwoPlayerMatrixGameStrategy, :player_number => 2, :id=>4)
      @payoff1 = stub_model(TwoPlayerMatrixGamePayoff, :strategy1 => @strategy1, :strategy2 => @strategy3)
      @payoff2 = stub_model(TwoPlayerMatrixGamePayoff, :strategy1 => @strategy1, :strategy2 => @strategy3)
      @payoff3 = stub_model(TwoPlayerMatrixGamePayoff, :strategy1 => @strategy2, :strategy2 => @strategy4)
      @payoff4 = stub_model(TwoPlayerMatrixGamePayoff, :strategy1 => @strategy2, :strategy2 => @strategy4)            
      @two_player_matrix_game = TwoPlayerMatrixGame.new
      @two_player_matrix_game.strategies = [@strategy1,@strategy2,@strategy3,@strategy4]
      @two_player_matrix_game.payoffs = [@payoff1, @payoff2, @payoff3, @payoff4]
    end
    
    it "should respond to columns_strategies" do
      @two_player_matrix_game.should respond_to :columns_strategies
    end
    
    it "should respond to lines_strategies" do
      @two_player_matrix_game.should respond_to :lines_strategies
    end
    
    it "should map player one on line strategies" do
      @two_player_matrix_game.lines_strategies.should == [@strategy1, @strategy2]
    end
    
    it "should map player two on columns strategies" do
      @two_player_matrix_game.columns_strategies.should == [@strategy3, @strategy4]
    end
    
    it "should respond to payoff_matrix" do
      @two_player_matrix_game.should respond_to :payoff_matrix
    end
    
    it "should map the payoffs correctly" do
      @two_player_matrix_game.payoff_matrix.should == [[@payoff1, @payoff2],[@payoff3, @payoff4]]
    end
  end
  
  it "should be able to associate payoffs to strategies by position" do
    # pending
    @strategy1 = stub_model(TwoPlayerMatrixGameStrategy, :player_number => 1, :id=>1, :number=>0)
    @strategy2 = stub_model(TwoPlayerMatrixGameStrategy, :player_number => 1, :id=>2, :number=>1)
    @strategy3 = stub_model(TwoPlayerMatrixGameStrategy, :player_number => 2, :id=>3, :number=>0)
    @strategy4 = stub_model(TwoPlayerMatrixGameStrategy, :player_number => 2, :id=>4, :number=>1)
    @payoff1 = stub_model(TwoPlayerMatrixGamePayoff, :line_position => 0, :column_position => 0)
    @payoff2 = stub_model(TwoPlayerMatrixGamePayoff, :line_position => 0, :column_position => 1)
    @payoff3 = stub_model(TwoPlayerMatrixGamePayoff, :line_position => 1, :column_position => 0)
    @payoff4 = stub_model(TwoPlayerMatrixGamePayoff, :line_position => 1, :column_position => 1)            
    @two_player_matrix_game = TwoPlayerMatrixGame.new
    @two_player_matrix_game.strategies = [@strategy1,@strategy2,@strategy3,@strategy4]
    @two_player_matrix_game.payoffs = [@payoff1, @payoff2, @payoff3, @payoff4]
    @payoff1.should_receive(:strategy1=).with(@strategy1)
    @payoff1.should_receive(:strategy2=).with(@strategy3)
    @payoff2.should_receive(:strategy1=).with(@strategy1)
    @payoff2.should_receive(:strategy2=).with(@strategy4)
    @payoff3.should_receive(:strategy1=).with(@strategy2)
    @payoff3.should_receive(:strategy2=).with(@strategy3)
    @payoff4.should_receive(:strategy1=).with(@strategy2)
    @payoff4.should_receive(:strategy2=).with(@strategy4)
    @two_player_matrix_game.associate_payoffs
    
    
    # , :strategy1 => @strategy1, :strategy2 => @strategy3
    # , :strategy1 => @strategy1, :strategy2 => @strategy3
    # , :strategy1 => @strategy2, :strategy2 => @strategy4
    # , :strategy1 => @strategy2, :strategy2 => @strategy4
  # def associate_payoffs
  #   self.payoffs.each do |payoff|
  #     payoff.strategy1 = self.lines_strategies.find {|s| s.number == payoff.line_position }
  #     payoff.strategy2 = self.columns_strategies.find {|s| s.number == payoff.column_position }
  #   end
  # end
  end
  

  describe 'initial setup for strategies and payoffs' do
    
    it "should have correctly assigned strategies after calling setup_strategies" do
      @two_player_matrix_game = TwoPlayerMatrixGame.new
      @two_player_matrix_game.should respond_to :setup_strategies
      @two_player_matrix_game.setup_strategies
      @two_player_matrix_game.strategies.size.should == 4
      @two_player_matrix_game.strategies.each_with_index do |strategy, i|
        strategy.player_number.should == 1 + (i/2)
      end
    end
    
    it "should have correctly assigned payoffs related to each strategy" do
      strategies = [stub_model(TwoPlayerMatrixGameStrategy, :player_number => 1),
      stub_model(TwoPlayerMatrixGameStrategy, :player_number => 1),
      stub_model(TwoPlayerMatrixGameStrategy, :player_number => 2),
      stub_model(TwoPlayerMatrixGameStrategy, :player_number => 2)]
      @two_player_matrix_game = TwoPlayerMatrixGame.new
      @two_player_matrix_game.strategies = strategies
      @two_player_matrix_game.should respond_to :setup_payoffs
      @two_player_matrix_game.setup_payoffs
      @two_player_matrix_game.payoffs.each_with_index do |payoff, i|
        payoff.should_not be_nil
        payoff.strategy1.should == strategies[i/2]
        payoff.strategy2.should == strategies[2+(i%2)]
      end
    end

    it "should call setup_strategies and setup_payoffs on initial_setup" do
      @two_player_matrix_game = TwoPlayerMatrixGame.new
      @two_player_matrix_game.should respond_to :initial_setup
      @two_player_matrix_game.should_receive(:setup_strategies)
      @two_player_matrix_game.should_receive(:setup_payoffs)
      @two_player_matrix_game.initial_setup
    end
    
    
  end
  
end
