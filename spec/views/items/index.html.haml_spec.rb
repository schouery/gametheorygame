require 'spec_helper'

describe "/items/index.html.haml" do
  include ItemsHelper

  before(:each) do
    @user_sets = assigns[:user_sets] = {
      stub_model(ItemSet, :name => "Item Set 1", :bonus_type => "hand_limit") => {
        stub_model(ItemType, :name => "Item Type 1") => stub_model(Item, :used => false),
        stub_model(ItemType, :name => "Item Type 2") => stub_model(Item, :used => true),
        stub_model(ItemType, :name => "Item Type 3") => nil
      },
      stub_model(ItemSet, :name => "Item Set 2", :bonus_type => "cards_per_hour") => {
        stub_model(ItemType, :name => "Item Type 4") => stub_model(Item, :used => true),
        stub_model(ItemType, :name => "Item Type 5") => nil,
        stub_model(ItemType, :name => "Item Type 6") => stub_model(Item, :used => false)
      }
    }
  end

  it "shows the ItemSets and ItemTypes" do
    render
    response.should contain("Item Set 1")
    response.should contain("Item Type 1")
    response.should contain("Item Type 2")
    response.should contain("Item Type 3")
    response.should contain("Hand limit")    
    response.should contain("Item Set 2")
    response.should contain("Item Type 4")
    response.should contain("Item Type 5")
    response.should contain("Item Type 6")
    response.should contain("Cards per hour")
  end
end
