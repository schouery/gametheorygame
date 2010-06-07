require 'spec_helper'

describe "/gifts/index.html.haml" do

  before(:each) do
    assigns[:cards] = @cards = [
      mock_model(Card, :game => mock_model(TwoPlayerMatrixGame, :name => "Game 1")),
      mock_model(Card, :game => mock_model(TwoPlayerMatrixGame, :name => "Game 2")),
      mock_model(Card, :game => mock_model(TwoPlayerMatrixGame, :name => "Game 3"))
      ]
  end
  
  it "renders" do
    render
    response.should contain "Game 1"
    response.should contain "Game 2"
    response.should contain "Game 3"
  end

end


