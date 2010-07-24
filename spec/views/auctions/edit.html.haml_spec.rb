require 'spec_helper'

describe "/auctions/edit.html.haml" do

  before(:each) do
    @date = 10.minutes.from_now
    assigns[:auction] = @auction = stub_model(Auction,
      :new_record? => false,
      :reserve_price => 2,
      :bid => 1,
      :end_date => @date,
      :item => stub_model(Item, :item_type => stub_model(ItemType, :name => "Item Type"))
    )
  end

  it "renders the edit auction form" do
    render
    response.should contain("2")
    response.should contain(@date.to_s)
    response.should contain("Item Type")
    response.should have_tag("form[action=#{auction_path(@auction)}][method=post]") do
      with_tag('input#auction_bid[name=?]', "auction[bid]")
    end
  end
end
