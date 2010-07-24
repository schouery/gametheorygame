require 'spec_helper'

describe "/symmetric_function_games/new.html.haml" do
  include SymmetricFunctionGamesHelper

  before(:each) do
    strategy = stub_model(SymmetricFunctionGameStrategy, :new_record? => true, :label => "Strategy")
    assigns[:symmetric_function_game] = stub_model(SymmetricFunctionGame, :new_record? => true,
      :strategies => [strategy, strategy])
  end

  it "renders new symmetric_function_game form" do
    render

    response.should have_tag("form[action=?][method=post]", symmetric_function_games_path) do
      with_tag("input#symmetric_function_game_name[name=?]", "symmetric_function_game[name]")
      with_tag("textarea#symmetric_function_game_description[name=?]", "symmetric_function_game[description]")
      with_tag("input#symmetric_function_game_number_of_players[name=?]", "symmetric_function_game[number_of_players]")

      [0,1].each do |i|
        with_tag("input#symmetric_function_game_strategies_attributes_#{i}_label[name=?]",
          "symmetric_function_game[strategies_attributes][#{i}][label]")
      end

      ["red", "green", "yellow"].each do |color|
        with_tag("input#symmetric_function_game_color_#{color}[name=?][type=?][value=?]", "symmetric_function_game[color]", "radio",color)
      end
      with_tag("input#symmetric_function_game_function[name=?]", "symmetric_function_game[function]")
    end
  end
end
