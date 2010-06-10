require 'spec_helper'

describe CardsController do

  before(:each) do
    Configuration.stub(:[]).with(:starting_money).and_return(100)
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1, :admin? => true)
    controller.stub!(:current_user).and_return(@current_user)
    @session = mock(Facebooker::Session, :user => @current_user)
    controller.stub!(:facebook_session).and_return @session
  end


  def mock_card(stubs={})
    @mock_card ||= mock_model(Card, stubs)
  end

  describe "GET played_cards" do
    it "assigns all player's played cards as @cards" do
      card_played = mock_model(Card, :played? => true)
      card_not_played = mock_model(Card, :played? => false)
      Card.stub(:find).with(:all, :conditions => {:user_id => @current_user.id}).and_return([card_played, card_not_played])
      get :played_cards
      assigns[:cards].should == [card_played]      
    end
  end

  describe "GET index" do
    it "assigns all player's not played cards as @cards" do
      card_played = mock_model(Card, :played? => true)
      card_not_played = mock_model(Card, :played? => false)
      Card.stub(:find).with(:all, :conditions => {:user_id => @current_user.id}).and_return([card_played, card_not_played])
      get :index
      assigns[:cards].should == [card_not_played]
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
        mock_card.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :card => {:these => 'params'}
      end
      
      it "tell the card's game to play" do
        card = mock_card(:update_attributes => true, :played? => false)
        Card.should_receive(:find).with("37").and_return(card)
        game = mock_model(SymmetricFunctionGame)
        card.should_receive(:game).and_return(game)
        game.should_receive(:play)
        put :update, :id => "37"
      end

      it "redirects to the symmetric_function_game" do
        Card.should_receive(:find).with("37").and_return(mock_card(:update_attributes => true,
         :game => mock_model(SymmetricFunctionGame, :play => true), :played? => false))
        put :update, :id => "37"
        response.should redirect_to(cards_url)
      end
    end

    describe "with invalid params" do
        
      it "updates the requested card" do
        Card.should_receive(:find).with("37").and_return(mock_card(:played? => false))
        mock_card.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :card => {:these => 'params'}
      end
    
      it "assigns the card as @card" do
        Card.should_receive(:find).with("37").and_return(mock_card(:update_attributes => false, :played? => false))
        put :update, :id => "37"
        assigns[:card].should equal(mock_card)
      end
    
      it "re-renders the 'edit' template" do
        Card.should_receive(:find).with("37").and_return(mock_card(:update_attributes => false, :played? => false))
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
