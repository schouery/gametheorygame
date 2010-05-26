require 'spec_helper'

describe "/games/index.html.haml" do
  include GamesHelper

  before(:each) do
    @games = assigns[:games] = [stub_model(SymmetricFunctionGame, :name => "Polution Game for 4", :id => 1),
              stub_model(SymmetricFunctionGame, :name => "Polution Game for 6", :id => 2),
              stub_model(TwoPlayerMatrixGame, :name => "Prisioner's Dilemma", :id => 3),
              stub_model(TwoPlayerMatrixGame, :name => "Battle of Sexes", :id => 4)]
    assigns[:paths] = {
      @games[0] => "/symmetric_function_games/",
      @games[1] => "/symmetric_function_games/",
      @games[2] => "/two_player_matrix_games/",
      @games[3] => "/two_player_matrix_games/"
    }
  end

  it "renders a list of cards" do
    render
    puts response.body
    @games.each do |game|
      response.should contain(game.name)
    end
    (1..2).each do |i|
      response.should have_tag("a[href='/symmetric_function_games/#{i}']", 'Show')
    end
    (3..4).each do |i|
      response.should have_tag("a[href='/two_player_matrix_games/#{i}']", 'Show')
    end
  end
end