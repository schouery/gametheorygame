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
    response.should have_tag("tr>td", "Polution Game for 4", 2)
    response.should have_tag("tr>td", "Polution Game, you should choose between polute or not.", 2)
    response.should have_tag("tr>td", 4.to_s, 2)
    response.should have_tag("tr>td", "Polute", 2)
    response.should have_tag("tr>td", "Not Polute", 2)
    response.should have_tag("tr>td", "red", 2)
    response.should have_tag("tr>td", "s[1] + p", 2)
  end
end
