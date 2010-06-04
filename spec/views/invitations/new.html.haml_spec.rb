require 'spec_helper'

describe "/invitations/new.html.haml" do
  include InvitationsHelper
  
  it "renders the friend select form" do
    render
    response.body.should have_multi_friend_selector_with(:action => "invitations",
    :url_for_invite => "http://apps.facebook.com/gametheorygamedev/cards",
    :invite? => true,
    :max => '.*')
  end
  
end


