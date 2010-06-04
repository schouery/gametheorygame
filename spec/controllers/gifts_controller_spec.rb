require 'spec_helper'

describe GiftsController do

  before(:each) do
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1, :facebook_id => 100, :admin? => true)
    controller.stub!(:current_user).and_return(@current_user)
    @session = mock(Facebooker::Session, :user => @current_user)
    controller.stub!(:facebook_session).and_return @session
  end

  describe "GET index" do
    it "lists all player's green cards as @cards" do
      green_card1 = mock_model(Card, :color => "green", :played? => false)
      green_card2 = mock_model(Card, :color => "green", :played? => false)
      green_card3 = mock_model(Card, :color => "green", :played? => true)
      red_card1 = mock_model(Card, :color => "red", :played? => false)
      @current_user.stub(:cards => [green_card1, green_card2, green_card3, red_card1])
      get :index
      assigns[:cards].should == [green_card1, green_card2]
    end
  end
  
  describe "GET money" do
    it "respond to money" do
      get :money
    end
  end
  
  describe "POST send_money" do
    it "creates the gifts" do
      MoneyGift.should_receive(:create).with(:facebook_id => 1, :value => 100)
      MoneyGift.should_receive(:create).with(:facebook_id => 2, :value => 100)
      @current_user.stub(:money => 300, :money= => true, :save => true)
      post :send_money, :ids => [1, 2]
    end
    
    it "removes this amount of money from player" do
      MoneyGift.stub(:create => true)
      @current_user.stub(:money => 300)
      @current_user.should_receive(:money=).with(100)
      @current_user.should_receive(:save)
      post :send_money, :ids => [1, 2]
      
    end
    
    it "redirect to index" do
      MoneyGift.stub(:create => true)
      @current_user.stub(:money => 300, :money= => true, :save => true)
      post :send_money, :ids => [1, 2]
      response.should redirect_to gifts_url
    end
  end

  describe "GET receive_money" do
    describe "with sucess" do
      it "gives the player the correct amount of money if he has this gift" do
        mock_gift = mock_model(MoneyGift, :facebook_id => @current_user.facebook_id, :value => 350, :destroy => true)
        MoneyGift.should_receive(:find).with("1").and_return(mock_gift)
        @current_user.stub(:money => 100)
        @current_user.should_receive(:money=).with(450)
        @current_user.should_receive(:save)
        get :receive_money, :id => 1      
      end
      
      it "destroys the gift" do
        mock_gift = mock_model(MoneyGift, :facebook_id => @current_user.facebook_id, :value => 350)
        MoneyGift.should_receive(:find).with("1").and_return(mock_gift)
        @current_user.stub(:money => 100, :money= => true, :save => true)
        mock_gift.should_receive(:destroy)
        get :receive_money, :id => 1            
        response.should redirect_to cards_url
      end
    
      it "should redirect to cards_url" do
        mock_gift = mock_model(MoneyGift, :facebook_id => @current_user.facebook_id, :value => 350, :destroy => true)
        MoneyGift.should_receive(:find).with("1").and_return(mock_gift)
        @current_user.stub(:money => 100, :money= => true, :save => true)
        get :receive_money, :id => 1            
        response.should redirect_to cards_url
      end
      
    end
    describe "falling" do
      it "shouldn't give the gift if this is not the player who has it" do
        mock_gift = mock_model(MoneyGift, :facebook_id => @current_user.facebook_id + 1, :value => 350)
        MoneyGift.should_receive(:find).with("1").and_return(mock_gift)
        get :receive_money, :id => 1      
      end

      it "should redirect to cards_url" do
        mock_gift = mock_model(MoneyGift, :facebook_id => @current_user.facebook_id + 1, :value => 350)
        MoneyGift.stub(:find => mock_gift)
        get :receive_money, :id => 1            
        response.should redirect_to cards_url
      end
    end
  end
  
end
