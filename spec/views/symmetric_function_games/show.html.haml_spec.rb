require 'spec_helper'

describe "/symmetric_function_games/show.html.haml" do
  include SymmetricFunctionGamesHelper
  
  before(:each) do
    @controller.stub(:can? => true)
    strategy1 = stub_model(SymmetricFunctionGameStrategy, :new_record? => true, :label => "Strategy1")
    strategy2 = stub_model(SymmetricFunctionGameStrategy, :new_record? => true, :label => "Strategy2")    
    assigns[:symmetric_function_game] = @symmetric_function_game = Factory.stub(:symmetric_function_game)
    @symmetric_function_game.should_receive(:strategies).and_return([strategy1, strategy2])
  end

  it "renders attributes in <p>" do
    render
    response.should have_text /Polution Game for 4/
    response.should have_text /Polution Game, you should choose between polute or not./
    response.should have_text /4/
    response.should have_text /Strategy1/
    response.should have_text /Strategy2/
    response.should have_text /red/
    response.should have_text /s\[1\] \+ p/
  end
end
