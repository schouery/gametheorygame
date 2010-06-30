require 'spec_helper'

describe "/rankings/index.html.haml" do

  before(:each) do
    assigns[:users] = [stub_model(User, :score => 10, :facebook_id => 1),
                       stub_model(User, :score => 5, :facebook_id => 2),
                       stub_model(User, :score => -2, :facebook_id => 3)]
  end

  it "renders the users and their score" do
    render
    response.body.should =~ /<fb:name capitalize='true' uid='1'><\/fb:name>/
    response.should have_text(/10/)
    response.body.should =~ /<fb:name capitalize='true' uid='2'><\/fb:name>/
    response.should have_text(/5/)
    response.body.should =~ /<fb:name capitalize='true' uid='3'><\/fb:name>/
    response.should have_text(/-2/)
  end

end