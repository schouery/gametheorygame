require 'spec_helper'

describe "/gifts/money.html.haml" do
  
  it "renders the friend select form for selecting one friend" do
    @current_user.stub(:max_money_gifts => 1)
    render
    response.body.should have_multi_friend_selector_with(:action => "gifts/send_money",
    :url_for_invite => "http://apps.facebook.com/gametheorygamedev/gifts/receive_money",
    :invite? => false,
    :max => @current_user.max_money_gifts)
  end

  it "renders the friend select form for selecting many friends" do
    @current_user.stub(:max_money_gifts => 4)
    render
    response.body.should have_multi_friend_selector_with(:action => "gifts/send_money",
    :url_for_invite => "http://apps.facebook.com/gametheorygamedev/gifts/receive_money",
    :invite? => false,
    :max => @current_user.max_money_gifts)
  end
  
  it "warns about not having enough money" do
    @current_user.stub(:max_money_gifts => 0)
    render
    response.body.should_not have_multi_friend_selector_with(:action => "gifts/send_money",
    :url_for_invite => "http://apps.facebook.com/gametheorygamedev/gifts/receive_money",
    :invite? => false,
    :max => @current_user.max_money_gifts)    
    response.should contain("You don't have enough money!")
  end
  
end


