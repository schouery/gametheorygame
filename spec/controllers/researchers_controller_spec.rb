require 'spec_helper'

describe ResearchersController do

  before(:each) do
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1, :facebook_id => 100, :admin? => true)
    controller.stub!(:current_user).and_return(@current_user)
    @session = mock(Facebooker::Session, :user => @current_user)
    controller.stub!(:facebook_session).and_return @session
  end

  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end

  def mock_invitation(stubs={})
    @mock_invitation ||= mock_model(Invitation, stubs)
  end

  describe "GET index" do
    it "assigns all researcher's that whom are not administrators as @researchers" do
      User.should_receive(:find).with(:first, :conditions=>{:facebook_id=>1})
      User.should_receive(:find).with(:all, :conditions => {:admin => false, :researcher => true}).and_return([mock_user])
      get :index
      assigns[:researchers].should == [mock_user]
    end
  end
  
  describe "GET new" do
  end

  describe "GET confirm" do
        
    describe "having an invitation" do
    
      it "should search for @current_user invitation" do
        conditions = {:facebook_id => @current_user.facebook_id, :for => 'researcher'}
        Invitation.should_receive(:find).with(:first, :conditions => conditions).and_return(mock_invitation(:destroy => true))
        @current_user.stub(:researcher= => true, :save => true)
        get :confirm
      end
            
      it "should make the @current_user a researcher" do
        Invitation.stub(:find => mock_invitation(:destroy => true))
        @current_user.should_receive(:researcher=).with(true)
        @current_user.should_receive(:save)
        get :confirm
      end
      
      it "should delete the invitation after making the user a researcher" do
        Invitation.stub(:find => mock_invitation)
        @current_user.stub(:researcher= => true, :save => true)
        mock_invitation.should_receive(:destroy)
        get :confirm        
      end
      
      it "should notice the user that he is now a researcher" do
        Invitation.stub(:find => mock_invitation(:destroy => true))
        @current_user.stub(:researcher= => true, :save => true)
        get :confirm
        flash[:notice].should == 'You are now a Researcher!'
      end

      it "redirects to cards_url" do
        Invitation.stub(:find => mock_invitation(:destroy => true))
        @current_user.stub(:researcher= => true, :save => true)
        get :confirm
        response.should redirect_to(cards_url)
      end
      
    end
    
    describe "not having an invitation" do
      
      it "should notice the user that he is now a researcher" do
        Invitation.stub(:find => nil)
        get :confirm
        flash[:notice].should == 'You need a invitation to be a Researcher!'
      end

      it "redirects to cards_url" do
        Invitation.stub(:find => nil)
        get :confirm
        response.should redirect_to(cards_url)
      end

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
      User.should_receive(:find).with(:first, :conditions=>{:facebook_id=>1})
      User.should_receive(:find).with("37").and_return(mock_user)
      mock_user.should_receive(:researcher=).with(false)
      mock_user.should_receive(:save)
      get :remove, :id => "37"
    end
  
    it "redirects to the researchers list" do
      User.stub(:find).and_return(mock_user(:destroy => true, :researcher= => true, :save => true))
      get :remove, :id => "1"
      response.should redirect_to(researchers_url)
    end
  end

end
