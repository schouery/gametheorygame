require 'spec_helper'
require 'controllers/controller_stub'

describe TwoPlayerMatrixGamesController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
  end

  def mock_two_player_matrix_game(stubs={})
    @mock_two_player_matrix_game ||= mock_model(TwoPlayerMatrixGame, stubs)
  end

  describe "GET show" do    
    it "assigns the requested two_player_matrix_game as @two_player_matrix_game" do
      TwoPlayerMatrixGame.stub(:find).with("37").and_return(mock_two_player_matrix_game)
      # mock_two_player_matrix_game.stub(:strategies => [])
      get :show, :id => "37"
      assigns[:two_player_matrix_game].should equal(mock_two_player_matrix_game)
    end
  end

  describe "GET new" do
    it "assigns a new two_player_matrix_game as @two_player_matrix_game" do
      TwoPlayerMatrixGame.stub(:new).and_return(mock_two_player_matrix_game(:initial_setup => true))
      get :new
      assigns[:two_player_matrix_game].should equal(mock_two_player_matrix_game)
    end
    
    it "creates empty payoffs and strategies for the game" do
      TwoPlayerMatrixGame.stub(:new).and_return(mock_two_player_matrix_game)
      mock_two_player_matrix_game.should_receive(:initial_setup)
      get :new      
    end
    
  end

  describe "GET edit" do
    it "assigns the requested two_player_matrix_game as @two_player_matrix_game" do
      TwoPlayerMatrixGame.stub(:find).with("37").and_return(mock_two_player_matrix_game(:fill_positions => true))
      get :edit, :id => "37"
      assigns[:two_player_matrix_game].should equal(mock_two_player_matrix_game)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created two_player_matrix_game as @two_player_matrix_game" do
        TwoPlayerMatrixGame.stub(:new).with({'these' => 'params'}).and_return(mock_two_player_matrix_game(:save => true, :associate_payoffs => true))
        mock_two_player_matrix_game.should_receive(:user=).with(@current_user)
        post :create, :two_player_matrix_game => {:these => 'params'}
        assigns[:two_player_matrix_game].should equal(mock_two_player_matrix_game)
      end

      it "redirects to the created two_player_matrix_game" do
        TwoPlayerMatrixGame.stub(:new).and_return(mock_two_player_matrix_game(:save => true, :associate_payoffs => true, :user= => true))
        post :create, :two_player_matrix_game => {}
        response.should redirect_to(two_player_matrix_game_url(mock_two_player_matrix_game))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved two_player_matrix_game as @two_player_matrix_game" do
        TwoPlayerMatrixGame.stub(:new).with({'these' => 'params'}).and_return(mock_two_player_matrix_game(:save => false,
         :associate_payoffs => true, :user= => true))
        post :create, :two_player_matrix_game => {:these => 'params'}
        assigns[:two_player_matrix_game].should equal(mock_two_player_matrix_game)
      end

      it "re-renders the 'new' template" do
        TwoPlayerMatrixGame.stub(:new).and_return(mock_two_player_matrix_game(:save => false, :associate_payoffs => true, :user= => true))
        post :create, :two_player_matrix_game => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested two_player_matrix_game" do
        TwoPlayerMatrixGame.should_receive(:find).with("37").and_return(mock_two_player_matrix_game)
        mock_two_player_matrix_game.should_receive(:update_attributes).with({'these' => 'params'}).and_return(true)
        mock_two_player_matrix_game.should_receive(:associate_payoffs)
        mock_two_player_matrix_game.should_receive(:save)
        put :update, :id => "37", :two_player_matrix_game => {:these => 'params'}
      end

      it "assigns the requested two_player_matrix_game as @two_player_matrix_game" do
        TwoPlayerMatrixGame.stub(:find).and_return(mock_two_player_matrix_game(:update_attributes => true, :associate_payoffs => true, :save => true))
        put :update, :id => "1"
        assigns[:two_player_matrix_game].should equal(mock_two_player_matrix_game)
      end

      it "redirects to the two_player_matrix_game" do
        TwoPlayerMatrixGame.stub(:find).and_return(mock_two_player_matrix_game(:update_attributes => true, :associate_payoffs => true, :save => true))
        put :update, :id => "1"
        response.should redirect_to(two_player_matrix_game_url(mock_two_player_matrix_game))
      end
    end

    describe "with invalid params" do
      it "updates the requested two_player_matrix_game" do
        TwoPlayerMatrixGame.should_receive(:find).with("37").and_return(mock_two_player_matrix_game)
        mock_two_player_matrix_game.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :two_player_matrix_game => {:these => 'params'}
      end

      it "assigns the two_player_matrix_game as @two_player_matrix_game" do
        TwoPlayerMatrixGame.stub(:find).and_return(mock_two_player_matrix_game(:update_attributes => false))
        put :update, :id => "1"
        assigns[:two_player_matrix_game].should equal(mock_two_player_matrix_game)
      end

      it "re-renders the 'edit' template" do
        TwoPlayerMatrixGame.stub(:find).and_return(mock_two_player_matrix_game(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "GET remove" do
    it "mark the requested two_player_matrix_game as removed" do
      TwoPlayerMatrixGame.should_receive(:find).with("37").and_return(mock_two_player_matrix_game)
      mock_two_player_matrix_game.should_receive(:removed=).with(true)
      mock_two_player_matrix_game.should_receive(:save)
      get :remove, :id => "37"
    end

    it "redirects to the games list" do
      TwoPlayerMatrixGame.stub(:find).and_return(mock_two_player_matrix_game(:removed= => true, :save => true))
      get :remove, :id => "1"
      response.should redirect_to(games_url)
    end
  end

  describe "GET statistics" do
    it "assigns the two_player_matrix_game as @two_player_matrix_game" do
      TwoPlayerMatrixGame.stub(:find).and_return(mock_two_player_matrix_game)
      get :statistics, :id => "1"
      assigns[:two_player_matrix_game].should equal(mock_two_player_matrix_game)
    end
  end

end
