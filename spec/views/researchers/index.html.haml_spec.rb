require 'spec_helper'

describe "/researchers/index.html.haml" do

  before(:each) do
    assigns[:researchers] = [
      mock_model(User, :facebook_id => 1, :id => 10),
      mock_model(User, :facebook_id => 2, :id => 20)
    ]
    @controller.stub(:can? => true)
  end

  it "renders a list of symmetric_function_games" do
    render    
    response.body.should =~ /<fb:name capitalize='true' linked='false' uid='1'><\/fb:name>/
    response.should have_tag("a[href=?]",'http://apps.facebook.com/gametheorygamedev/researchers/10/remove')
    response.body.should =~ /<fb:name capitalize='true' linked='false' uid='2'><\/fb:name>/
    response.should have_tag("a[href=?]",'http://apps.facebook.com/gametheorygamedev/researchers/20/remove')
  end
end
