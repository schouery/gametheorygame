require 'spec_helper'

describe "/symmetric_function_games/show.html.haml" do
  include SymmetricFunctionGamesHelper
  
  before(:each) do
    @controller.stub(:can? => true)
    strategy1 = stub_model(SymmetricFunctionGameStrategy, :new_record? => true, :label => "Polute")
    strategy2 = stub_model(SymmetricFunctionGameStrategy, :new_record? => true, :label => "Not Polute")    
    assigns[:symmetric_function_game] = @symmetric_function_game = stub_model(SymmetricFunctionGame, 
      :name => "Polution Game for 4",
      :description => "Polution Game, you should choose between polute or not.",
      :number_of_players => "4",
      :strategies => [strategy1, strategy2],
      :color => "red",
      :function => "np[0] + 3*st[1]"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should contain "Polution Game for 4"
    response.should contain "Polution Game, you should choose between polute or not."
    response.should contain "4"
    response.should contain "Polute"
    response.should contain "Not Polute"
    response.should contain "red"
    response.should contain "np[0] + 3*st[1]"
  end
end
