require 'spec_helper'

describe GamesController do

  before(:each) do
    controller.stub!(:ensure_application_is_installed_by_facebook_user)
    @current_user = mock_model(User, :id => 1, :to_i => 1)
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
  end

end
