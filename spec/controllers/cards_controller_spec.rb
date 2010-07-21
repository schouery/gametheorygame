require 'spec_helper'
require 'controllers/controller_stub'

describe CardsController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
  end

  def mock_card(stubs={})
    @mock_card ||= mock_model(Card, stubs)
  end

  describe "GET played_cards" do
    it "assigns all player's played cards as @cards" do
      Card.stub(:find).with(:all, :conditions => {:user_id => @current_user.id, :played => true}).and_return([mock_card])
      get :played_cards
      assigns[:cards].should == [mock_card]
    end
  end

  describe "GET index" do
    it "assigns all player's not played cards as @cards" do
      Card.stub(:find).with(:all, :conditions => {:user_id => @current_user.id, :played => false}).and_return([mock_card])
      Item.stub(:find).and_return(nil)
      get :index
      assigns[:cards].should == [mock_card]
    end
    
    it "assigns all player's not used items as @items" do
      items = [mock_model(Item), mock_model(Item)]
      Card.stub(:find).and_return(nil)
      Item.stub(:find).with(:all, :conditions => {:user_id => @current_user.id, :used => false}).and_return(items)
      get :index
      assigns[:items].should == items
    end
    
  end

  describe "GET edit" do
    it "assigns the requested card as @card" do
      Card.stub(:find).with("37").and_return(mock_card(:game_type => "SomeGame", :played? => false))
      get :edit, :id => "37"
      assigns[:card].should equal(mock_card)
      assigns[:partial].should == "some_games/card"
    end
    
    it "redirects to card_url if the card was already played" do
      Card.stub(:find).with("37").and_return(mock_card(:game_type => "SomeGame", :played? => true))
      get :edit, :id => "37"
      response.should redirect_to cards_url
    end
    
  end
  
  describe "PUT update" do

    describe "with valid params" do
            
      it "updates the requested card" do
        Card.should_receive(:find).with("37").and_return(mock_card(:played? => false))
        mock_card.should_receive(:played=).with(true)
        mock_card.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :card => {:these => 'params'}
      end
      
      it "tell the card's game to play" do
        card = mock_card(:update_attributes => true, :played? => false, :played= => true)
        Card.should_receive(:find).with("37").and_return(card)
        game = mock_model(SymmetricFunctionGame)
        card.should_receive(:game).and_return(game)
        game.should_receive(:play)
        put :update, :id => "37"
      end

      it "redirects to the symmetric_function_game" do
        Card.should_receive(:find).with("37").and_return(mock_card(:update_attributes => true,
         :game => mock_model(SymmetricFunctionGame, :play => true), :played? => false, :played= => true))
        put :update, :id => "37"
        response.should redirect_to(cards_url)
      end
    end

    describe "with invalid params" do
        
      it "updates the requested card" do
        Card.should_receive(:find).with("37").and_return(mock_card(:played? => false, :played= => true))
        mock_card.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :card => {:these => 'params'}
      end
    
      it "assigns the card as @card" do
        Card.should_receive(:find).with("37").and_return(mock_card(:update_attributes => false, :played? => false, :played= => true))
        put :update, :id => "37"
        assigns[:card].should equal(mock_card)
      end
    
      it "re-renders the 'edit' template" do
        Card.should_receive(:find).with("37").and_return(mock_card(:update_attributes => false, :played? => false, :played= => true))
        put :update, :id => "37"
        response.should render_template('edit')
      end
    end
    
    describe "with played card" do
      it "should redirect to cards_url" do
        Card.should_receive(:find).with("37").and_return(mock_card(:update_attributes => true, :played? => true))
        put :update, :id => "37"
        response.should redirect_to cards_url
      end
    end
  end
    
  describe "GET discard" do
    it "destroys the requested card" do
      Card.should_receive(:find).with("37").and_return(mock_card)
      mock_card.should_receive(:destroy)
      get :discard, :id => "37"
    end

    it "redirects to the cards list" do
      Card.stub(:find).and_return(mock_card(:destroy => true))
      get :discard, :id => "1"
      response.should redirect_to(cards_url)
    end
  end


end
