require 'spec_helper'

describe "/cards/index.html.haml" do
  include CardsHelper

  before(:each) do
    @game1 = stub_model(SymmetricFunctionGame, :name => "Polution Game for 4")
    @game2 = stub_model(SymmetricFunctionGame, :name => "Polution Game for 6")
    assigns[:cards] = [
      stub_model(Card,
        :symmetric_function_game => @game1
      ),
      stub_model(Card,
        :symmetric_function_game => @game2
      )
    ]
  end

  it "renders a list of cards" do
    render
    response.should have_tag("tr>td", "Polution Game for 4", 2)
    response.should have_tag("tr>td", "Polution Game for 6", 2)
  end
end