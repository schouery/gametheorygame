require 'spec_helper'

describe "/symmetric_function_games/edit.html.haml" do
  include SymmetricFunctionGamesHelper

  before(:each) do
    assigns[:symmetric_function_game] = @symmetric_function_game = Factory.stub(:symmetric_function_game)
  end

  it "renders the edit symmetric_function_game form" do
    render

    response.should have_tag("form[action=#{symmetric_function_game_path(@symmetric_function_game)}][method=post]") do
      with_tag('input#symmetric_function_game_name[name=?]', "symmetric_function_game[name]")
      with_tag('textarea#symmetric_function_game_description[name=?]', "symmetric_function_game[description]")
      with_tag('input#symmetric_function_game_number_of_players[name=?]', "symmetric_function_game[number_of_players]")
      with_tag('input#symmetric_function_game_label_1[name=?]', "symmetric_function_game[label_1]")
      with_tag('input#symmetric_function_game_label_2[name=?]', "symmetric_function_game[label_2]")
      ["red", "green", "yellow"].each do |color|
        with_tag("input#symmetric_function_game_color_#{color}[name=?][type=?][value=?]", "symmetric_function_game[color]", "radio",color)
      end
      with_tag('input#symmetric_function_game_function[name=?]', "symmetric_function_game[function]")
    end
  end
end
