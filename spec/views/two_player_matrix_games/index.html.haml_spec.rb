require 'spec_helper'

describe "/two_player_matrix_games/index.html.haml" do
  include TwoPlayerMatrixGamesHelper

  before(:each) do
    assigns[:two_player_matrix_games] = [
      stub_model(TwoPlayerMatrixGame,
        :name => "Battle of Sexes",
        :color => "green"
      ),
      stub_model(TwoPlayerMatrixGame,
        :name => "Prisoner's Dilemma",
        :color => "red"
      )
    ]
  end

  it "renders a list of two_player_matrix_games" do
    render
    response.should contain("Battle of Sexes")
    response.should contain("green")
    response.should contain("Prisoner's Dilemma")
    response.should contain("red")
  end
end
