require 'spec_helper'
require 'controllers/controller_stub'

describe InvitationsController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
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
