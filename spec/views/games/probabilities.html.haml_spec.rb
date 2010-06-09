require 'spec_helper'

describe "/games/probabilities.html.haml" do
  include GamesHelper

  before(:each) do
    @matrix_game1 = mock_model(TwoPlayerMatrixGame, :id => 1, :weight => 1, :name => "MG1", :color => "green")
    @matrix_game2 = mock_model(TwoPlayerMatrixGame, :id => 2, :weight => 1, :name => "MG2", :color => "red") 
    @function_game1 = mock_model(SymmetricFunctionGame, :id => 1, :weight => 1, :name => "FG1", :color => "yellow")
    @function_game3 = mock_model(SymmetricFunctionGame, :id => 3, :weight => 1, :name => "FG3", :color => "green")
    assigns[:games] = [@matrix_game1, @function_game1, @matrix_game2, @function_game3] 
  end

  it "renders a list of cards" do
    render    
    response.should have_tag("form[action=?][method=?]", "/games/update_probabilities?method=post", "post") do
      with_tag("table") do
        expected_line(@matrix_game1, "two_player_matrix_game")
        expected_line(@matrix_game2, "two_player_matrix_game")
        expected_line(@function_game1, "symmetric_function_game")
        expected_line(@function_game3, "symmetric_function_game")
      end
    end
  end
  
  def expected_line(game, type)
    with_tag("tr") do
      with_tag("td", game.name)
      with_tag("td", game.color)
      with_tag("td>input[id=?][name=?]", "#{type}_#{game.id}_weight", "#{type}[#{game.id}][weight]")
    end
  end

end