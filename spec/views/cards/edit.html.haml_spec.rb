require 'spec_helper'

describe "/cards/edit.html.haml" do
  include CardsHelper

  before(:each) do
    @strategies = [
    stub_model(SymmetricFunctionGameStrategy, :new_record? => true, :label => "Strategy1", :id => 1),
    stub_model(SymmetricFunctionGameStrategy, :new_record? => true, :label => "Strategy2", :id => 2)
    ]
    @symmetric_function_game = Factory.stub(:symmetric_function_game)
    @symmetric_function_game.stub!(:strategies => @strategies)
    assigns[:card] = @card = stub_model(Card, :new_record? => false, :game => @symmetric_function_game)
  end

  it "renders the edit card form" do
    render

    response.should have_tag("form[action=#{card_path(@card)}][method=post]") do
      @strategies.each do |strategy|
        with_tag("input#card_strategy_id_#{strategy.id}[name=?][type=?][value=?]",
        "card[strategy_id]", "radio", strategy.id)      
      end
    end
  end
  
  it "renders game info" do
    render
    response.should contain(@symmetric_function_game.name)
    response.should contain(@symmetric_function_game.description)
    response.should contain(@symmetric_function_game.number_of_players.to_s)
    response.should contain(@symmetric_function_game.color)
    @strategies.each do |strategy|
      response.should contain(strategy.label)
    end
  end
end
