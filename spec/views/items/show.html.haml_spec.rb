require 'spec_helper'

describe "/items/show.html.haml" do
  include ItemsHelper
  before(:each) do
    @item = assigns[:item] = stub_model(Item, :used => false)
    assigns[:item_type] = stub_model(ItemType, :name => "Item Type 1")
    @item_set = assigns[:item_set] = stub_model(ItemSet, :name => "Item Set 1", :bonus_type => "hand_limit")
    @item_set.should_receive(:items_for).and_return(
      {
        stub_model(ItemType, :name => "Item Type 1") => @item,
        stub_model(ItemType, :name => "Item Type 2") => stub_model(Item, :used => true),
        stub_model(ItemType, :name => "Item Type 3") => nil
      }
    )
  end

  it "renders attributes in <p>" do
    render
    response.should contain("Item Type 1")
    response.should contain("Item Set 1")
    response.should contain("Item Type 1")
    response.should contain("Item Type 2")
    response.should contain("Item Type 3")
    response.should contain("Hand limit")
  end
end
