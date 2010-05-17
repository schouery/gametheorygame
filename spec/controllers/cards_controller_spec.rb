require 'spec_helper'

describe CardsController do

  before(:each) do
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1)
    controller.stub!(:current_user).and_return(@current_user)
    @session = mock(Facebooker::Session, :user => @current_user)
    controller.stub!(:facebook_session).and_return @session
  end


  def mock_card(stubs={})
    @mock_card ||= mock_model(Card, stubs)
  end

  describe "GET index" do
    it "assigns all player's cards as @cards" do
      Card.stub(:find).with(:all, :conditions => {:user_id => @current_user.id}).and_return([mock_card])
      get :index
      assigns[:cards].should == [mock_card]
    end
  end
  
  describe "GET show" do
    it "assigns the requested card as @card" do
      Card.stub(:find).with("37").and_return(mock_card)
      get :show, :id => "37"
      assigns[:card].should equal(mock_card)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested card" do
      Card.should_receive(:find).with("37").and_return(mock_card)
      mock_card.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the cards list" do
      Card.stub(:find).and_return(mock_card(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(cards_url)
    end
  end

end
