require 'spec_helper'

describe "/games/inactive.html.haml" do
  include GamesHelper

  before(:each) do
    @games = assigns[:games] = [stub_model(SymmetricFunctionGame, :name => "Polution Game for 4", :id => 1, :removed => true),
                                stub_model(SymmetricFunctionGame, :name => "Polution Game for 6", :id => 2, :removed => true),
                                stub_model(TwoPlayerMatrixGame, :name => "Prisioner's Dilemma", :id => 3, :removed => true),
                                stub_model(TwoPlayerMatrixGame, :name => "Battle of Sexes", :id => 4, :removed => true)]
  end

  it "renders a list of cards" do
    render
    @games.each do |game|
      response.should contain(game.name)
    end
    (1..4).each do |i|
      response.should have_tag("a[href='http://apps.facebook.com/gametheorygamedev/games/#{i}/activate']", 'Activate')
    end
  end
end