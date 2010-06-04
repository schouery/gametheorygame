require 'spec_helper'

describe "/gifts/money.html.haml" do
  before(:each) do
    @current_user.stub(:money => 200)
  end
  
  it "renders the friend select form" do
    render
    response.body.should have_multi_friend_selector_with(:action => "gifts/send_money",
    :url_for_invite => "http://apps.facebook.com/gametheorygamedev/gifts/receive_money",
    :invite? => false,
    :max => '2')
  end
  
end


