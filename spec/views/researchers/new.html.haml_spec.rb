require 'spec_helper'

describe "/researchers/new.html.haml" do

  before(:each) do
    @controller.stub!(:can? => true)
  end

  it "renders a multi-friend-selector" do
    render        
    response.body.should have_multi_friend_selector_with(:action => "researchers",
    :url_for_invite => "http://apps.facebook.com/gametheorygamedev/researchers/confirm",
    :invite? => true,
    :max => '.*')
  end
end
