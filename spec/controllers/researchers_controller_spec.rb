require 'spec_helper'
require 'controllers/controller_stub'

describe ResearchersController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end

  def mock_invitation(stubs={})
    @mock_invitation ||= mock_model(Invitation, stubs)
  end

  describe "GET index" do
    it "assigns all researcher's that whom are not administrators as @researchers" do
      User.should_receive(:researchers).and_return([mock_user])
      get :index
      assigns[:researchers].should == [mock_user]
    end
  end
  
  describe "GET new" do
    it "assigns all researchers and admins that are friends of the user as @exclude_ids" do
      @session.user.stub(:friends_with_this_app => [
          stub(Facebooker::User, :id => 1),
          stub(Facebooker::User, :id => 2),
          stub(Facebooker::User, :id => 3),
          stub(Facebooker::User, :id => 4)])
      User.stub(:find).with(:first, :conditions => {:facebook_id => 1}).and_return(mock_model(User, :admin? => false, :researcher? => false))
      User.stub(:find).with(:first, :conditions => {:facebook_id => 2}).and_return(mock_model(User, :admin? => true, :researcher? => false))
      User.stub(:find).with(:first, :conditions => {:facebook_id => 3}).and_return(mock_model(User, :admin? => false, :researcher? => true))      
      User.stub(:find).with(:first, :conditions => {:facebook_id => 4}).and_return(nil)      
      get :new
      assigns[:exclude_ids].should == '2,3'
    end
  end

  describe "GET confirm" do    
    it "should search for @current_user invitation" do
      conditions = {:facebook_id => @current_user.facebook_id, :for => 'researcher'}
      Invitation.should_receive(:find).with(:first, :conditions => conditions).and_return(mock_invitation)
      mock_invitation.should_receive(:promote).with(@current_user)
      @current_user.stub(:researcher= => true, :save => true)
      get :confirm
    end
          
    it "should notice the user that he is now a researcher" do
      Invitation.stub(:find => mock_invitation(:promote => true))
      get :confirm
      flash[:notice].should == 'You are now a Researcher!'
    end

    it "redirects to cards_url" do
      Invitation.stub(:find => mock_invitation(:promote => true))
      get :confirm
      response.should redirect_to(cards_url)
    end      
  end

  describe "POST create" do
    it "create invitations for confirmation" do
      Invitation.should_receive(:create).with(:facebook_id => 1, :for => 'researcher')
      post :create, :ids => [1]
      response.should redirect_to(cards_url)
    end
  end

  describe "GET remove" do
    it "remove researcher permission from user" do
      # User.should_receive(:find).with(:first, :conditions=>{:facebook_id=>1})
      User.should_receive(:find).with("37").and_return(mock_user)
      mock_user.should_receive(:researcher=).with(false)
      mock_user.should_receive(:save)
      get :remove, :id => "37"
    end
  
    it "redirects to the researchers list if the user can see it now" do
      User.stub(:find).and_return(mock_user(:destroy => true, :researcher= => true, :save => true))
      get :remove, :id => @current_user.id + 1
      response.should redirect_to(researchers_url)
    end

    it "redirects to the card list if the user can't see the researcher's list" do
      @current_user.stub(:destroy => true, :researcher= => true, :save => true)
      User.stub(:find).and_return(@current_user)
      get :remove, :id => @current_user.id
      response.should redirect_to(cards_url)
    end
  end

end
