require 'spec_helper'

describe "/two_player_matrix_games/statistics.html.haml" do

  include TwoPlayerMatrixGamesHelper

  before(:each) do
    soccer_1 = stub_model(TwoPlayerMatrixGame, :label => "Soccer", :player_number => 1)
    soccer_2 = stub_model(TwoPlayerMatrixGame, :label => "Soccer", :player_number => 2)
    movies_1 = stub_model(TwoPlayerMatrixGame, :label => "Movies", :player_number => 1)
    movies_2 = stub_model(TwoPlayerMatrixGame, :label => "Movies", :player_number => 2)
    @payoff_1 = stub_model(TwoPlayerMatrixGamePayoff, :strategy_1 => soccer_1, :strategy_2 => soccer_2, 
      :payoff_player_1 => 6, :payoff_player_2 => 5)
    @payoff_2 = stub_model(TwoPlayerMatrixGamePayoff, :strategy_1 => movies_1, :strategy_2 => soccer_2, 
      :payoff_player_1 => 0, :payoff_player_2 => 0)
    @payoff_3 = stub_model(TwoPlayerMatrixGamePayoff, :strategy_1 => soccer_1, :strategy_2 => movies_1, 
      :payoff_player_1 => 1, :payoff_player_2 => 1)
    @payoff_4 = stub_model(TwoPlayerMatrixGamePayoff, :strategy_1 => movies_1, :strategy_2 => movies_2, 
      :payoff_player_1 => 5, :payoff_player_2 => 6)
    @card1 = stub_model(Card, :strategy => @soccer1)
    @card2 = stub_model(Card, :strategy => @movies1)
    @card3 = stub_model(Card, :strategy => @soccer2)
    @card4 = stub_model(Card, :strategy => @movies2)
               
    assigns[:two_player_matrix_game] = @two_player_matrix_game = stub_model(TwoPlayerMatrixGame,
      :name => "Battle of Sexes",
      :lines_strategies => [soccer_1, movies_1],
      :columns_strategies => [soccer_2, movies_2],
      :results_matrix => [[0,0],[0,0]]
    )
  end

  it "renders attributes in <p>" do
    render
    response.should contain("Battle of Sexes")
  end
  
  it "should work when we have one occurence of each result" do
    @two_player_matrix_game.stub(:results_matrix => [[0.25,0.25],[0.25,0.25]])    
    render
    response.should have_tag("table") do
      first_line(["Soccer", "Movies"])
      line(2, "Soccer", ["25.0%", "25.0%"])
      line(3, "Movies", ["25.0%", "25.0%"])
    end
  end

  it "should work when we have one occurence of each result" do
    @two_player_matrix_game.stub(:results_matrix => [[0.5,0.2],[0.2,0.1]])    
    render
    response.should have_tag("table") do
      first_line(["Soccer", "Movies"])
      line(2, "Soccer", ["50.0%", "20.0%"])
      line(3, "Movies", ["20.0%", "10.0%"])
    end
  end
  
  def first_line(labels)
    with_tag("tr[id=?]",1.to_s) do
      with_tag('td[id=1]', '')
      labels.each_with_index do |label, i|
        with_tag('td[id=?]', (i+2).to_s, label)
      end
    end
  end
  
  def line(number, label, percentages)
    with_tag('tr[id=?]',number.to_s) do
      with_tag('td[id=?]', '1', label)
      percentages.each_with_index do |percentage, i|
        with_tag('td[id=?]', (i+2).to_s, percentage.to_s)
      end
    end
  end
  
end
