require 'spec_helper'

describe "/cards/show.html.haml" do
  include CardsHelper
  before(:each) do
    @user = stub_model(User)
    @game = stub_model(SymmetricFunctionGame, :name => "Polution Game for 4")
    assigns[:card] = @card = stub_model(Card,
      :user => @user,
      :symmetric_function_game => @game
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/Polution Game for 4/)
  end
end
