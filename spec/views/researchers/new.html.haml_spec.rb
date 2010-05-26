require 'spec_helper'

describe "/researchers/index.html.haml" do

  before(:each) do
    assigns[:researchers] = [
      mock_model(User, :facebook_id => 1, :id => 10),
      mock_model(User, :facebook_id => 2, :id => 20)
    ]
  end

  it "renders a list of symmetric_function_games" do
    pending
    options = {:next_action => researchers_url,
      :button_name => 'Be a Researcher',                                                   
      :actiontext => 'Invite your friends to be a researcher',                             
      :path_for_invitation => confirm_researchers_url,                                     
      :content => 'Create experiments on The Game Theory Game'}
    puts @controller.template.inspect
    template.should_receive(:render).with('shared/multi_friend_selector', :options => options)
    render    
  end
end
