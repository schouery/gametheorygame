require 'spec_helper'
require 'controllers/controller_stub'

describe GiftsController do
  include ControllerStub
  before (:each) do
    basic_controller_stub
  end

  describe "GET index" do
    it "lists all player's green cards as @cards and player's not used items as @items" do
      card1 = mock_model(Card, :can_send? => true)
      card2 = mock_model(Card, :can_send? => true)
      card3 = mock_model(Card, :can_send? => false)
      item1 = mock_model(Item, :used => false)
      item2 = mock_model(Item, :used => false)
      @current_user.stub(:cards => [card1, card2, card3])
      @current_user.stub(:items => mock(Array, :not_used => [item1, item2]))
      get :index
      assigns[:cards].should == [card1, card2]
      assigns[:items].should == [item1, item2]
    end
  end
  
  describe "POST send_money" do
    describe "with enough money" do
      before(:each) do
        @current_user.stub(:max_money_gifts => 3, :money => 300)
        @value_for_gift = 150
        Configuration.stub!(:[]).with(:money_gift_value).and_return(@value_for_gift)
      end
      
      it "creates the gifts" do
        MoneyGift.should_receive(:create).with(:facebook_id => 1, :value => @value_for_gift)
        MoneyGift.should_receive(:create).with(:facebook_id => 2, :value => @value_for_gift)
        @current_user.stub(:money= => true, :save => true)
        post :send_money, :ids => [1, 2]
      end
    
      it "removes this amount of money from player" do
        MoneyGift.stub(:create => true)
        @current_user.should_receive(:money=).with(@current_user.money - 2*@value_for_gift)
        @current_user.should_receive(:save)
        post :send_money, :ids => [1, 2]      
      end
    
      it "redirect to index" do
        MoneyGift.stub(:create => true)
        @current_user.stub(:money= => true, :save => true)
        post :send_money, :ids => [1, 2]
        response.should redirect_to gifts_url
      end
      
    end

    describe "without enough money" do
      before(:each) do
        Configuration.stub!(:[]).with(:money_gift_value).and_return(@value_for_gift)
        @current_user.stub(:max_money_gifts => 0)
      end

      it "renders money and flashs a notice" do
        post :send_money, :ids => [1, 2]
        response.should render_template('money')
        flash[:notice].should == "Action failed: You can't send so many gifts"
      end
    end
    
  end

  describe "GET receive_money" do
    it "gives the player the correct amount of money if he has this gift" do
      mock_gift = mock_model(MoneyGift, :facebook_id => @current_user.facebook_id, :value => 350, :destroy => true)
      MoneyGift.should_receive(:find).with(:first, :conditions => {:facebook_id => @current_user.facebook_id}).and_return(mock_gift)
      @current_user.stub(:money => 100)
      @current_user.should_receive(:money=).with(450)
      @current_user.should_receive(:save)
      get :receive_money, :id => @current_user.facebook_id      
    end
  
    it "destroys the gift" do
      mock_gift = mock_model(MoneyGift, :facebook_id => @current_user.facebook_id, :value => 350)
      MoneyGift.stub(:find => mock_gift)
      @current_user.stub(:money => 100, :money= => true, :save => true)
      mock_gift.should_receive(:destroy)
      get :receive_money, :id => 1            
      response.should redirect_to cards_url
    end

    it "should redirect to cards_url" do
      mock_gift = mock_model(MoneyGift, :facebook_id => @current_user.facebook_id, :value => 350, :destroy => true)
      MoneyGift.stub(:find => mock_gift)
      @current_user.stub(:money => 100, :money= => true, :save => true)
      get :receive_money, :id => 1            
      response.should redirect_to cards_url
    end
  end

  describe "GET card" do
    
    it "assigns the card as @card if it can be sended" do
      mock_card = mock_model(Card, :can_send_as_gift? => true)
      Card.should_receive(:find).with("1").and_return(mock_card)
      get :card, :id => 1
      assigns[:card].should == mock_card
    end
    
    it "redirects to gifts_url if it can't send the card and warns the player" do
      mock_card = mock_model(Card, :can_send_as_gift? => false, :gift_error => "Error")
      Card.should_receive(:find).with("1").and_return(mock_card)
      get :card, :id => 1
      response.should redirect_to gifts_url
      flash[:notice].should == "Error"
    end
    
  end
  
  describe "POST send_card" do
    describe "with a green and not played card" do
      it "sends the card" do
        mock_card = mock_model(Card)
        Card.should_receive(:find).with("10").and_return(mock_card)
        mock_card.should_receive(:send_as_gift).with(@current_user, 101).and_return(true)
        post :send_card, :id => 10, :ids => [101]
      end
        
      it "redirect to index" do
        mock_card = mock_model(Card, :send_as_gift => true)
        Card.stub(:find => mock_card)
        post :send_card, :id => 10, :ids => [101]
        response.should redirect_to gifts_url
      end
    end
    
    describe "with a forbidden card" do
      it "redirect to index and warns the player for a card that can't be sended" do
        mock_card = mock_model(Card, :send_as_gift => false, :gift_error => "Error")
        Card.stub(:find => mock_card)
        post :send_card, :id => 10, :ids => [101]
        response.should redirect_to gifts_url
        flash[:notice].should == "Error"
      end
    end
    
  end
  
  describe "GET receive_card" do
    
    describe "with sucess" do
      it "gives the player the card if he has this gift" do
        mock_card = mock_model(Card, :gift_for => @current_user.facebook_id)
        Card.should_receive(:find).with("1").and_return(mock_card)
        mock_card.should_receive(:user=).with(@current_user)
        mock_card.should_receive(:gift_for=).with(nil)
        mock_card.should_receive(:save)
        get :receive_card, :id => 1      
      end

      it "should redirect to cards_url" do
        mock_card = mock_model(Card, :user= => true, :save => true, :gift_for= => true, :gift_for => @current_user.facebook_id)
        Card.stub(:find => mock_card)
        get :receive_card, :id => 1      
        response.should redirect_to cards_url
      end  
    end

    describe "falling" do
      it "shouldn't give the gift if this is not the player who has it" do
        mock_card = mock_model(Card, :gift_for => @current_user.facebook_id + 1)
        Card.stub(:find => mock_card)
        get :receive_card, :id => 1      
      end
  
      it "should redirect to cards_url" do
        mock_card = mock_model(Card, :gift_for => @current_user.facebook_id + 1)
        Card.stub(:find => mock_card)
        get :receive_card, :id => 1      
        response.should redirect_to cards_url
      end
    end

  end

  describe "GET item" do
    
    it "assigns the item as @item if it can be sended" do
      mock_item = mock_model(Item, :can_send_as_gift? => true)
      Item.should_receive(:find).with("1").and_return(mock_item)
      get :item, :id => 1
      assigns[:item].should == mock_item
    end
    
    it "redirects to gifts_url if it can't send the item and warns the player" do
      mock_item = mock_model(Item, :can_send_as_gift? => false, :gift_error => "Error")
      Item.should_receive(:find).with("1").and_return(mock_item)
      get :item, :id => 1
      response.should redirect_to gifts_url
      flash[:notice].should == "Error"
    end
    
  end
  
  describe "POST send_item" do
    describe "with a permited item" do
      it "sends the item" do
        mock_item = mock_model(Item)
        Item.should_receive(:find).with("10").and_return(mock_item)
        mock_item.should_receive(:send_as_gift).with(@current_user, 101).and_return(true)
        post :send_item, :id => 10, :ids => [101]
      end
        
      it "redirect to index" do
        mock_item = mock_model(Item, :send_as_gift => true)
        Item.stub(:find => mock_item)
        post :send_item, :id => 10, :ids => [101]
        response.should redirect_to gifts_url
      end
    end
    
    describe "with a forbidden item" do
      it "redirect to index and warns the player for a item that can't be sended" do
        mock_item = mock_model(Item, :send_as_gift => false, :gift_error => "Error")
        Item.stub(:find => mock_item)
        post :send_item, :id => 10, :ids => [101]
        response.should redirect_to gifts_url
        flash[:notice].should == "Error"
      end
    end
    
  end
  
  describe "GET receive_item" do
    
    describe "with sucess" do
      it "gives the player the item if he has this gift" do
        mock_item = mock_model(Item, :gift_for => @current_user.facebook_id)
        Item.should_receive(:find).with("1").and_return(mock_item)
        mock_item.should_receive(:user=).with(@current_user)
        mock_item.should_receive(:gift_for=).with(nil)
        mock_item.should_receive(:save)
        get :receive_item, :id => 1      
      end

      it "should redirect to cards_url" do
        mock_item = mock_model(Item, :user= => true, :save => true, :gift_for= => true, :gift_for => @current_user.facebook_id)
        Item.stub(:find => mock_item)
        get :receive_item, :id => 1      
        response.should redirect_to cards_url
      end  
    end

    describe "falling" do
      it "shouldn't give the gift if this is not the player who has it" do
        mock_item = mock_model(Item, :gift_for => @current_user.facebook_id + 1)
        Item.stub(:find => mock_item)
        get :receive_item, :id => 1      
      end
  
      it "should redirect to cards_url" do
        mock_item = mock_model(Item, :gift_for => @current_user.facebook_id + 1)
        Item.stub(:find => mock_item)
        get :receive_item, :id => 1      
        response.should redirect_to cards_url
      end
    end

  end
    
end
