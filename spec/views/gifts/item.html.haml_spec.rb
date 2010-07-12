require 'spec_helper'

describe "/gifts/item.html.haml" do
  
  before(:each) do
    @item = assigns[:item] = stub_model(Item, :item_type => stub_model(ItemType, :name => "Item Type"), :id => 1)
  end

  it "renders the friend select form for selecting one friend if you can send a item" do
    render
    response.should contain "Send a Item Type"
    response.body.should have_multi_friend_selector_with(:action => "gifts/1/send_item",
    :url_for_invite => "http://apps.facebook.com/gametheorygamedev/gifts/1/receive_item",
    :invite? => false,
    :max => '1')
  end
end