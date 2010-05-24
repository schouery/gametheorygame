require 'spec_helper'

describe "/researchers/index.html.haml" do

  before(:each) do
    assigns[:researchers] = [
      mock_model(User, :facebook_id => 1, :id => 10),
      mock_model(User, :facebook_id => 2, :id => 20)
    ]
  end

  it "renders a list of symmetric_function_games" do
    render    
    response.body.should =~ /<fb:name capitalize='true' uid='1'><\/fb:name>/
    response.should have_tag("a[href=?]",'/researchers/10/remove')
    response.body.should =~ /<fb:name capitalize='true' uid='2'><\/fb:name>/
    response.should have_tag("a[href=?]",'/researchers/20/remove')
  end
end