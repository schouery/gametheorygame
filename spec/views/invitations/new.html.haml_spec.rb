require 'spec_helper'

describe "/invitations/new.html.haml" do
  include InvitationsHelper
  
  it "renders the friend select form" do
    render
  end
end


