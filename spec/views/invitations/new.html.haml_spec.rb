require 'spec_helper'

describe "/invitations/new.html.haml" do
  include InvitationsHelper
  
  before(:each) do
    assigns[:exclude_ids] = @exclude_ids = "1,2"
  end
    
  it "renders the friend select form" do
    render
    response.body.should have_multi_friend_selector_with(:action => "invitations",
    :url_for_invite => "http://apps.facebook.com/gametheorygamedev/cards",
    :invite? => true,
    :max => '.*',
    :exclude_ids => @exclude_ids)
  end
  
end


