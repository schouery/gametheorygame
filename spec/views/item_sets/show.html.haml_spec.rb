require 'spec_helper'

describe "/item_sets/show.html.haml" do
  include ItemSetsHelper
  before(:each) do
    @item_types = [stub_model(ItemType, :name => "Item Type 1"),
                   stub_model(ItemType, :name => "Item Type 2"),
                   stub_model(ItemType, :name => "Item Type 3")]
    assigns[:item_set] = @item_set = stub_model(ItemSet,
      :name => "Item Set",
      :item_types => @item_types, 
      :bonus_type => "hand_limit"
    )
    @controller.stub(:can? => true)
  end

  it "renders attributes in <p>" do
    render
    response.should contain(@item_set.name)
    @item_types.each do |item_type|
      response.should contain(item_type.name)
    end
    response.should contain("Hand limit")
  end
end
