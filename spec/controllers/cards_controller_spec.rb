require 'spec_helper'

describe CardsController do

  def mock_card(stubs={})
    @mock_card ||= mock_model(Card, stubs)
  end

  def mock_current_user(stubs={})
    @current_user = mock_model(User, stubs)
    controller.stub!(:current_user).and_return(@current_user)
  end

  describe "GET index" do
    it "assigns all player's cards as @cards" do
      mock_current_user(:id => 1)
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
