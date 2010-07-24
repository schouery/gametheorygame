require 'spec_helper'

describe "/auctions/index.html.haml" do

  before(:each) do
    @date1 = 5.minutes.from_now
    @date2 = 15.minutes.from_now
    assigns[:auctions] = [
      stub_model(Auction,
        :item => stub_model(Item, :item_type => stub_model(ItemType, :name => "Item Type 1")),
        :end_date => @date1,
        :reserve_price => 10,
        :bid => 20
      ),
      stub_model(Auction,
        :item => stub_model(Item, :item_type => stub_model(ItemType, :name => "Item Type 2")),
        :end_date => @date2,
        :reserve_price => 30,
        :bid => 40
      )
    ]
  end

  it "renders a list of auctions" do
    render
    response.should contain("Item Type 1")
    response.should contain(10.to_s)
    response.should contain(20.to_s)
    response.should contain(@date1.to_s)
    response.should contain("Item Type 2")
    response.should contain(30.to_s)
    response.should contain(40.to_s)
    response.should contain(@date2.to_s)
  end
end

