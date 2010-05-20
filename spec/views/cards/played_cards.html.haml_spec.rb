require 'spec_helper'

describe "/cards/played_cards.html.haml" do
  include CardsHelper

  before(:each) do
    @game1 = stub_model(SymmetricFunctionGame, :name => "Polution Game for 4")
    @game2 = stub_model(SymmetricFunctionGame, :name => "Polution Game for 6")
    @strategy1 = stub_model(SymmetricFunctionGameStrategy, :label => "Polute")
    @strategy2 = stub_model(SymmetricFunctionGameStrategy, :label => "Not Polute")
    assigns[:cards] = [
      stub_model(Card,
        :game => @game1,
        :strategy => @strategy1
      ),
      stub_model(Card,
        :game => @game2,
        :strategy => @strategy2,
        :payoff => 10
      )
    ]
  end

  it "renders a list of cards" do
    render
    response.should contain(@game1.name)
    response.should contain(@strategy1.label)
    response.should contain("Not calculated yet")
    response.should contain(@game2.name)
    response.should contain(@strategy2.label)
    response.should contain("10")
  end
end