require 'spec_helper'

describe "/cards/index.html.haml" do
  include CardsHelper

  before(:each) do
    @game1 = stub_model(SymmetricFunctionGame, :name => "Polution Game for 4", :color => "red")
    @game2 = stub_model(SymmetricFunctionGame, :name => "Polution Game for 6", :color => "red")
    @item_type1 = stub_model(ItemType, :name => "Item Type 1")
    @item_type2 = stub_model(ItemType, :name => "Item Type 2")
    assigns[:cards] = [stub_model(Card, :game => @game1),
                       stub_model(Card, :game => @game2)]
    assigns[:items] = [stub_model(Item, :item_type => @item_type1),
                       stub_model(Item, :item_type => @item_type2)]                   
    @controller.stub(:can? => true)
  end

  it "renders a list of cards" do
    render
    response.should contain(@game1.name)
    response.should contain(@game2.name)
    response.should contain(@item_type1.name)
    response.should contain(@item_type2.name)
  end
end