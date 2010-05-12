require 'spec_helper'

describe "/symmetric_function_games/show.html.haml" do
  include SymmetricFunctionGamesHelper
  
  before(:each) do
    assigns[:symmetric_function_game] = @symmetric_function_game = Factory.stub(:symmetric_function_game)
  end

  it "renders attributes in <p>" do
    render
    response.should have_text /Polution Game for 4/
    response.should have_text /Polution Game, you should choose between polute or not./
    response.should have_text /4/
    response.should have_text /Polute/
    response.should have_text /Not Polute/
    response.should have_text /red/
    response.should have_text /s\[1\] \+ p/
  end
end
