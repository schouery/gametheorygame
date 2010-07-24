require 'spec_helper'

describe "/researchers/new.html.haml" do

  before(:each) do
    assigns[:exclude_ids] = @exclude_ids = '1,2'
    @controller.stub!(:can? => true)
  end

  it "renders a multi-friend-selector" do
    render        
    response.body.should have_multi_friend_selector_with(:action => "researchers",
      :url_for_invite => "http://apps.facebook.com/gametheorygamedev/researchers/confirm",
      :invite? => true,
      :max => '.*',
      :exclude_ids => @exclude_ids)
  end
  
end
