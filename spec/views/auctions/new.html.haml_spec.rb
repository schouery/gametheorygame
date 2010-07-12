require 'spec_helper'

describe "/auctions/new.html.haml" do
  include AuctionsHelper

  before(:each) do
    @date = 10.minutes.from_now
    @item = assigns[:item] = stub_model(Item, :item_type => stub_model(ItemType, :name => "Item Type"))
    assigns[:auction] = stub_model(Auction, 
    :new_record? => true,
    :end_date => @date)
  end

  it "renders new auction form" do
    render
    response.should contain("Item Type")
    response.should contain(@date.to_s)
    response.should have_tag("form[action=?][method=post]", auctions_path) do
      with_tag("input#auction_reserve_price[name=?]", "auction[reserve_price]")
    end
  end
end