require 'spec_helper'

describe "/two_player_matrix_games/new.html.haml" do
  include TwoPlayerMatrixGamesHelper

  before(:each) do
    soccer_1 = stub_model(TwoPlayerMatrixGame, :label => "Soccer", :player_number => 1, :number => 0)
    soccer_2 = stub_model(TwoPlayerMatrixGame, :label => "Soccer", :player_number => 2, :number => 0)
    movies_1 = stub_model(TwoPlayerMatrixGame, :label => "Movies", :player_number => 1, :number => 1)
    movies_2 = stub_model(TwoPlayerMatrixGame, :label => "Movies", :player_number => 2, :number => 1)
    @payoff_1 = stub_model(TwoPlayerMatrixGamePayoff, :strategy_1 => soccer_1, :strategy_2 => soccer_2, 
    :payoff_player_1 => 6, :payoff_player_2 => 5, :line_position => 0, :column_position => 0)
    @payoff_2 = stub_model(TwoPlayerMatrixGamePayoff, :strategy_1 => movies_1, :strategy_2 => soccer_2, 
    :payoff_player_1 => 0, :payoff_player_2 => 0, :line_position => 0, :column_position => 1)
    @payoff_3 = stub_model(TwoPlayerMatrixGamePayoff, :strategy_1 => soccer_1, :strategy_2 => movies_1, 
    :payoff_player_1 => 1, :payoff_player_2 => 1, :line_position => 1, :column_position => 0)
    @payoff_4 = stub_model(TwoPlayerMatrixGamePayoff, :strategy_1 => movies_1, :strategy_2 => movies_2, 
    :payoff_player_1 => 5, :payoff_player_2 => 6, :line_position => 1, :column_position => 1)
    
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

  it "renders the new two_player_matrix_game form" do
    render
    response.should have_tag("form[action=#{two_player_matrix_game_path(@two_player_matrix_game)}][method=post]") do
      with_tag('input#two_player_matrix_game_name[name=?]', "two_player_matrix_game[name]")
      with_tag('textarea#two_player_matrix_game_description[name=?]', "two_player_matrix_game[description]")
      with_tag('input#two_player_matrix_game_color[name=?]', "two_player_matrix_game[color]")
      with_tag('table') do
        first_line(["Soccer", "Movies"])
        line(2, "Soccer", [@payoff_1, @payoff_2])
        line(3, "Movies", [@payoff_3, @payoff_4])
      end
    end
  end
  
  def first_line(labels)
    with_tag("tr[id=?]",1.to_s) do
      with_tag('td[id=1]', '')
      labels.each_with_index do |label, i|
        with_tag('td[id=?]', (i+2).to_s) do
          with_tag("input#two_player_matrix_game_strategies_attributes_#{i}_label[name=?]", 
                   "two_player_matrix_game[strategies_attributes][#{i}][label]")
        end
      end
    end
  end
  
  def line(number, label, payoffs)
    with_tag('tr[id=?]',number.to_s) do
      with_tag('td[id=?]', '1') do
        with_tag("input#two_player_matrix_game_strategies_attributes_#{number}_label[name=?]", 
                 "two_player_matrix_game[strategies_attributes][#{number}][label]")
      end
      payoffs.each_with_index do |payoff, i|
        with_tag('td[id=?]', (i+2).to_s) do
          table_for_payoff(payoff, (number-2)*payoffs.size + i)
        end
      end
    end
  end
  
  def table_for_payoff(payoff, number)
    with_tag('table') do
      with_tag('tr') do
        with_tag('td', '')
        with_tag('td') do
          with_tag("input#two_player_matrix_game_payoffs_attributes_#{number}_payoff_player_1[name=?]", 
                  "two_player_matrix_game[payoffs_attributes][#{number}][payoff_player_1]")
        end
      end
      with_tag('tr') do
        with_tag('td') do
          with_tag("input#two_player_matrix_game_payoffs_attributes_#{number}_payoff_player_2[name=?]", 
                  "two_player_matrix_game[payoffs_attributes][#{number}][payoff_player_2]")
        end
        with_tag('td', '')
      end      
    end      
  end
  
end
