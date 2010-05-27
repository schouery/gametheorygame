require 'spec_helper'

describe SymmetricFunctionGamesController do

  before(:each) do
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1)
    controller.stub!(:current_user).and_return(@current_user)
    @session = mock(Facebooker::Session, :user => @current_user)
    controller.stub!(:facebook_session).and_return @session
  end

  def mock_symmetric_function_game(stubs={})
    @mock_symmetric_function_game ||= mock_model(SymmetricFunctionGame, stubs)
  end

  describe "GET index" do
    it "assigns all symmetric_function_games as @symmetric_function_games" do
      SymmetricFunctionGame.stub(:find).with(:all).and_return([mock_symmetric_function_game])
      get :index
      assigns[:symmetric_function_games].should == [mock_symmetric_function_game]
    end
  end

  describe "GET show" do
    it "assigns the requested symmetric_function_game as @symmetric_function_game" do
      SymmetricFunctionGame.stub(:find).with("37").and_return(mock_symmetric_function_game)
      get :show, :id => "37"
      assigns[:symmetric_function_game].should equal(mock_symmetric_function_game)
    end
  end

  describe "GET new" do
    it "assigns a new symmetric_function_game as @symmetric_function_game" do
      SymmetricFunctionGame.stub(:new).and_return(mock_symmetric_function_game)
      mocked_array = mock(Array)
      mock_symmetric_function_game.should_receive(:strategies).twice.and_return(mocked_array)
      mocked_array.should_receive(:build).twice
      get :new
      assigns[:symmetric_function_game].should equal(mock_symmetric_function_game)
    end
  end

  describe "GET edit" do
    it "assigns the requested symmetric_function_game as @symmetric_function_game" do
      SymmetricFunctionGame.stub(:find).with("37").and_return(mock_symmetric_function_game)
      get :edit, :id => "37"
      assigns[:symmetric_function_game].should equal(mock_symmetric_function_game)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created symmetric_function_game as @symmetric_function_game" do
        SymmetricFunctionGame.stub(:new).with({'these' => 'params'}).and_return(mock_symmetric_function_game(:save => true))
        post :create, :symmetric_function_game => {:these => 'params'}
        assigns[:symmetric_function_game].should equal(mock_symmetric_function_game)
      end

      it "redirects to the created symmetric_function_game" do
        SymmetricFunctionGame.stub(:new).and_return(mock_symmetric_function_game(:save => true))
        post :create, :symmetric_function_game => {}
        response.should redirect_to(symmetric_function_game_url(mock_symmetric_function_game))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved symmetric_function_game as @symmetric_function_game" do
        SymmetricFunctionGame.stub(:new).with({'these' => 'params'}).and_return(mock_symmetric_function_game(:save => false))
        post :create, :symmetric_function_game => {:these => 'params'}
        assigns[:symmetric_function_game].should equal(mock_symmetric_function_game)
      end

      it "re-renders the 'new' template" do
        SymmetricFunctionGame.stub(:new).and_return(mock_symmetric_function_game(:save => false))
        post :create, :symmetric_function_game => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested symmetric_function_game" do
        SymmetricFunctionGame.should_receive(:find).with("37").and_return(mock_symmetric_function_game)
        mock_symmetric_function_game.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :symmetric_function_game => {:these => 'params'}
      end

      it "assigns the requested symmetric_function_game as @symmetric_function_game" do
        SymmetricFunctionGame.stub(:find).and_return(mock_symmetric_function_game(:update_attributes => true))
        put :update, :id => "1"
        assigns[:symmetric_function_game].should equal(mock_symmetric_function_game)
      end

      it "redirects to the symmetric_function_game" do
        SymmetricFunctionGame.stub(:find).and_return(mock_symmetric_function_game(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(symmetric_function_game_url(mock_symmetric_function_game))
      end
    end

    describe "with invalid params" do
      it "updates the requested symmetric_function_game" do
        SymmetricFunctionGame.should_receive(:find).with("37").and_return(mock_symmetric_function_game)
        mock_symmetric_function_game.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :symmetric_function_game => {:these => 'params'}
      end

      it "assigns the symmetric_function_game as @symmetric_function_game" do
        SymmetricFunctionGame.stub(:find).and_return(mock_symmetric_function_game(:update_attributes => false))
        put :update, :id => "1"
        assigns[:symmetric_function_game].should equal(mock_symmetric_function_game)
      end

      it "re-renders the 'edit' template" do
        SymmetricFunctionGame.stub(:find).and_return(mock_symmetric_function_game(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested symmetric_function_game" do
      SymmetricFunctionGame.should_receive(:find).with("37").and_return(mock_symmetric_function_game)
      mock_symmetric_function_game.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the symmetric_function_games list" do
      SymmetricFunctionGame.stub(:find).and_return(mock_symmetric_function_game(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(symmetric_function_games_url)
    end
  end

  describe "GET statistics" do
    it "assigns the symmetric_function_game as @symmetric_function_game" do
      SymmetricFunctionGame.stub(:find).with("37").and_return(mock_symmetric_function_game)
      get :statistics, :id => "37"
      assigns[:symmetric_function_game].should equal(mock_symmetric_function_game)
    end
  end

end
