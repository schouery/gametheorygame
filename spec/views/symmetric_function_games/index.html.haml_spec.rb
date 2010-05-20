require 'spec_helper'

describe "/symmetric_function_games/index.html.haml" do
  include SymmetricFunctionGamesHelper

  before(:each) do
    assigns[:symmetric_function_games] = [
      Factory.stub(:symmetric_function_game),
      Factory.stub(:symmetric_function_game)
    ]
  end

  it "renders a list of symmetric_function_games" do
    render    
    response.should contain("Polution Game for 4")
    response.should contain("4")
    response.should contain("red")
  end
end
