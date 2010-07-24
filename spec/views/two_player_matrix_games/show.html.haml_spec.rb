require 'spec_helper'

describe "/two_player_matrix_games/show.html.haml" do

  include TwoPlayerMatrixGamesHelper

  before(:each) do
    @controller.stub(:can? => true)
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
    
    assigns[:two_player_matrix_game] = @two_player_matrix_game = stub_model(TwoPlayerMatrixGame,
      :name => "Battle of Sexes",
      :color => "green",
      :description => "Do you want to go to watch soccer or a movie?",
      :strategies => [soccer_1, movies_1, soccer_2, movies_2],
      :lines_strategies => [soccer_1, movies_1],
      :columns_strategies => [soccer_2, movies_2],
      :payoff_matrix => [[@payoff_1, @payoff_2],[@payoff_3, @payoff_4]]
    )
  end

  it "renders attributes in <p>" do
    render
    response.should contain("Battle of Sexes")
    response.should contain("Green")
    response.should contain("Do you want to go to watch soccer or a movie?")
    response.should have_tag("table") do
      first_line(["Soccer", "Movies"])
      line(2, "Soccer", [@payoff_1, @payoff_2])
      line(3, "Movies", [@payoff_3, @payoff_4])
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
  
  def line(number, label, payoffs)
    with_tag('tr[id=?]',number.to_s) do
      with_tag('td[id=?]', '1', label)
      payoffs.each_with_index do |payoff, i|
        with_tag('td[id=?]', (i+2).to_s) do
          table_for_payoff(payoff)
        end
      end
    end
  end
  
  def table_for_payoff(payoff)
    with_tag('table') do
      with_tag('tr') do
        with_tag('td', '')
        with_tag('td', payoff.payoff_player_1.to_s)
      end
      with_tag('tr') do
        with_tag('td', payoff.payoff_player_2.to_s)
        with_tag('td', '')
      end      
    end      
  end

end
