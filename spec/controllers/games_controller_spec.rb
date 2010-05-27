require 'spec_helper'

describe GamesController do

  before(:each) do
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1, :admin? => true)
    controller.stub!(:current_user).and_return(@current_user)
    @session = mock(Facebooker::Session, :user => @current_user)
    controller.stub!(:facebook_session).and_return @session
  end

  describe "GET index" do
    it "assigns all games as @games" do
      matrix_games = [mock_model(TwoPlayerMatrixGame), mock_model(TwoPlayerMatrixGame)]
      function_games = [mock_model(SymmetricFunctionGame), mock_model(SymmetricFunctionGame)]
      TwoPlayerMatrixGame.should_receive(:find).with(:all).and_return(matrix_games)
      SymmetricFunctionGame.should_receive(:find).with(:all).and_return(function_games)
      get :index
      assigns[:games].should == matrix_games + function_games
    end
    
    it "assigns the games paths as @paths" do
      m1, m2 = mock_model(TwoPlayerMatrixGame), mock_model(TwoPlayerMatrixGame)
      matrix_games = [m1,m2]
      f1, f2 = mock_model(SymmetricFunctionGame), mock_model(SymmetricFunctionGame)
      function_games = [f1, f2]
      TwoPlayerMatrixGame.should_receive(:find).with(:all).and_return(matrix_games)
      SymmetricFunctionGame.should_receive(:find).with(:all).and_return(function_games)
      get :index
      assigns[:paths].should == {m1 => '/two_player_matrix_games/', m2 => '/two_player_matrix_games/',
        f1 => '/symmetric_function_games/', f2 => '/symmetric_function_games/'}
    end
  end
end
