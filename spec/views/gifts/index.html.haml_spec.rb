require 'spec_helper'

describe "/gifts/index.html.haml" do

  before(:each) do
    assigns[:cards] = @cards = [
      mock_model(Card, :game => mock_model(TwoPlayerMatrixGame, :name => "Game 1")),
      mock_model(Card, :game => mock_model(TwoPlayerMatrixGame, :name => "Game 2")),
      mock_model(Card, :game => mock_model(TwoPlayerMatrixGame, :name => "Game 3"))
    ]
    assigns[:items] = @items = [
      mock_model(Item, :item_type => stub_model(ItemType, :name => "Item Type 1")),
      mock_model(Item, :item_type => stub_model(ItemType, :name => "Item Type 2")),
      mock_model(Item, :item_type => stub_model(ItemType, :name => "Item Type 3"))
    ]
    @gift_log = stub_model(GiftLog)
    @user = stub_model(User, :gift_log => @gift_log)
    @controller.stub(:current_user => @user)
  end
  
  it "renders the cards if the player can send any of them" do
    @gift_log.stub(:maximum_gifts_today).with(:item).and_return(1)
    @gift_log.stub(:maximum_gifts_today).with(:card).and_return(1)
    render
    response.should contain "Game 1"
    response.should contain "Game 2"
    response.should contain "Game 3"
  end

  it "renders the items if the player can send any of them" do
    @gift_log.stub(:maximum_gifts_today).with(:item).and_return(1)
    @gift_log.stub(:maximum_gifts_today).with(:card).and_return(1)
    render
    response.should contain "Item Type 1"
    response.should contain "Item Type 2"
    response.should contain "Item Type 3"
  end
  
  it "warns the player if he can't send any more cards" do
    @gift_log.stub(:maximum_gifts_today).with(:item).and_return(1)
    @gift_log.stub(:maximum_gifts_today).with(:card).and_return(0)
    render
    response.should contain "You can't send more cards today."
  end

  it "warns the player if he can't send any more items" do
    @gift_log.stub(:maximum_gifts_today).with(:card).and_return(1)
    @gift_log.stub(:maximum_gifts_today).with(:item).and_return(0)
    render
    response.should contain "You can't send more items today."
  end

end


