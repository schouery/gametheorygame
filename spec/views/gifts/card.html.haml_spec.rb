require 'spec_helper'

describe "/gifts/card.html.haml" do
  
  before(:each) do
    @card = assigns[:card] = stub_model(Card, :game => stub_model(TwoPlayerMatrixGame, :name => "Game 1"), :id => 1)
  end

  it "renders the friend select form for selecting one friend" do
    render
    response.should contain "Send a Game 1 Card"
    response.body.should have_multi_friend_selector_with(:action => "gifts/1/send_card",
    :url_for_invite => "http://apps.facebook.com/gametheorygamedev/gifts/1/receive_card",
    :invite? => false,
    :max => '1')
  end

end