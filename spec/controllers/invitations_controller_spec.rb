require 'spec_helper'

describe InvitationsController do

  before(:each) do
    Configuration.stub(:[]).with(:starting_money).and_return(100)
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1, :facebook_id => 100, :admin? => true)
    controller.stub!(:current_user).and_return(@current_user)
    @session = mock(Facebooker::Session, :user => @current_user)
    controller.stub!(:facebook_session).and_return @session
    controller.stub!(:set_current_user => true)    
  end

  describe "GET index" do
    it "redirects to card_url" do
      get :index
      response.should redirect_to(cards_url)
    end
  end

  describe "GET new" do
    it "assigns the frinds with this app as @exclude_ids " do
      @session.user.stub(:friends_with_this_app => [stub(Facebooker::User, :id => 1),
        stub(Facebooker::User, :id => 2),
        stub(Facebooker::User, :id => 3)])
      get :new
      assigns[:exclude_ids].should == "1,2,3"
    end        
    
  end

  describe "POST create" do
    it "redirects to card_url" do
      post :create, :ids => [1]
      response.should redirect_to(cards_url)
    end
  end


end
