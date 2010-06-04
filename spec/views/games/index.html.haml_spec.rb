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
    @controller.stub(:can? => true)
  end

  it "renders a list of cards" do
    render
    @games.each do |game|
      response.should contain(game.name)
    end
    (1..2).each do |i|
      response.should have_tag("a[href='http://apps.facebook.com/gametheorygamedev/symmetric_function_games/#{i}']", 'Show')
      response.should have_tag("a[href='http://apps.facebook.com/gametheorygamedev/symmetric_function_games/#{i}/statistics']", 'Statistics')
    end
    (3..4).each do |i|
      response.should have_tag("a[href='http://apps.facebook.com/gametheorygamedev/two_player_matrix_games/#{i}']", 'Show')
      response.should have_tag("a[href='http://apps.facebook.com/gametheorygamedev/two_player_matrix_games/#{i}/statistics']", 'Statistics')
    end
  end
end