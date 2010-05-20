require 'spec_helper'

describe Card do
  it { should belong_to(:user) }
  it { should belong_to(:symmetric_function_game) }
  it { should belong_to(:symmetric_function_game_strategy)}
  it { should have_column(:payoff).type(:integer) }
  
  describe "generate payoff" do
  
    before(:each) do
      @game = mock_model(SymmetricFunctionGame)
      @strategy = mock_model(SymmetricFunctionGameStrategy)
    end
  
    it "should prevent the player playing with himself"
    
    it "should respond to play" do
      Card.new.should respond_to :play
    end
    
    it "should do nothing if it's the only card played" do
      card = Card.new(:symmetric_function_game => @game,
        :symmetric_function_game_strategy => @strategy)
      @game.should_receive(:calculate_payoffs).and_return(nil)  
      card.play
      card.payoff.should be_nil
    end
    
    it "should receive it's payoff if it was the last played card" do
      card = Card.new(:symmetric_function_game => @game,
        :symmetric_function_game_strategy => @strategy)
      @game.should_receive(:calculate_payoffs).and_return(10)
      card.play
      card.payoff.should == 10
    end
    
  end
  
end
