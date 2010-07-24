require 'spec_helper'
require 'controllers/controller_stub'

describe GamesController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
  end

  describe "GET index" do
    it "assigns all games as @games" do
      matrix_games = [mock_model(TwoPlayerMatrixGame), mock_model(TwoPlayerMatrixGame)]
      function_games = [mock_model(SymmetricFunctionGame), mock_model(SymmetricFunctionGame)]
      TwoPlayerMatrixGame.should_receive(:not_removed).and_return(matrix_games)
      SymmetricFunctionGame.should_receive(:not_removed).and_return(function_games)
      get :index
      assigns[:games].should == function_games + matrix_games
    end    
  end
  
  describe "GET probabilities" do
    it "assigns all games as @games" do
      matrix_games = [mock_model(TwoPlayerMatrixGame), mock_model(TwoPlayerMatrixGame)]
      function_games = [mock_model(SymmetricFunctionGame), mock_model(SymmetricFunctionGame)]
      TwoPlayerMatrixGame.should_receive(:not_removed).and_return(matrix_games)
      SymmetricFunctionGame.should_receive(:not_removed).and_return(function_games)
      get :probabilities
      assigns[:games].should == function_games + matrix_games
    end
  end
  
  describe "PUT update_probabilities" do    
    describe "with valid params" do
      it "updates the requested games" do
        two_player_matrix_games = [mock_model(TwoPlayerMatrixGame, :valid? => true), mock_model(TwoPlayerMatrixGame, :valid? => true)]
        symmetric_function_games = [mock_model(SymmetricFunctionGame, :valid? => true), mock_model(SymmetricFunctionGame, :valid? => true)]
        TwoPlayerMatrixGame.should_receive(:update).with(["1", "2"], [{"weight" => "1"}, {"weight" => "3"}]).and_return(two_player_matrix_games)
        SymmetricFunctionGame.should_receive(:update).with(["1", "3"],[{"weight" => "10"},{"weight" => "5"}]).and_return(symmetric_function_games)
        put :update_probabilities, :two_player_matrix_game => {"1" => {:weight => "1"}, "2" => {:weight => "3"}},
          :symmetric_function_game => {"1" => {:weight => "10"}, "3" => {:weight => "5"}}
      end

      it "assigns the requested games as @games" do
        two_player_matrix_games = [mock_model(TwoPlayerMatrixGame, :valid? => true), mock_model(TwoPlayerMatrixGame, :valid? => true)]
        symmetric_function_games = [mock_model(SymmetricFunctionGame, :valid? => true), mock_model(SymmetricFunctionGame, :valid? => true)]
        TwoPlayerMatrixGame.stub(:update).and_return(two_player_matrix_games)
        SymmetricFunctionGame.stub(:update).and_return(symmetric_function_games)
        put :update_probabilities, :two_player_matrix_game => {"1" => {:weight => "1"}, "2" => {:weight => "3"}},
          :symmetric_function_game => {"1" => {:weight => "10"}, "3" => {:weight => "5"}}
        assigns[:games].should == symmetric_function_games + two_player_matrix_games
      end

      it "redirects to the two_player_matrix_game" do
        TwoPlayerMatrixGame.stub(:update).and_return([])
        SymmetricFunctionGame.stub(:update).and_return([])
        put :update_probabilities, :two_player_matrix_game => {}, :symmetric_function_game => {}
        response.should redirect_to(games_url)
      end
    end

    describe "with invalid params" do
      it "updates the requested games" do
        two_player_matrix_games = [mock_model(TwoPlayerMatrixGame, :valid? => false), mock_model(TwoPlayerMatrixGame, :valid? => true)]
        symmetric_function_games = [mock_model(SymmetricFunctionGame, :valid? => true), mock_model(SymmetricFunctionGame, :valid? => true)]
        TwoPlayerMatrixGame.should_receive(:update).with(["1", "2"], [{"weight" => "1"}, {"weight" => "3"}]).and_return(two_player_matrix_games)
        SymmetricFunctionGame.should_receive(:update).with(["1", "3"],[{"weight" => "10"},{"weight" => "5"}]).and_return(symmetric_function_games)
        put :update_probabilities, :two_player_matrix_game => {"1" => {:weight => "1"}, "2" => {:weight => "3"}},
          :symmetric_function_game => {"1" => {:weight => "10"}, "3" => {:weight => "5"}}
      end

      it "assigns the requested games as @games" do
        two_player_matrix_games = [mock_model(TwoPlayerMatrixGame, :valid? => false), mock_model(TwoPlayerMatrixGame, :valid? => true)]
        symmetric_function_games = [mock_model(SymmetricFunctionGame, :valid? => true), mock_model(SymmetricFunctionGame, :valid? => true)]
        TwoPlayerMatrixGame.stub(:update).and_return(two_player_matrix_games)
        SymmetricFunctionGame.stub(:update).and_return(symmetric_function_games)
        put :update_probabilities, :two_player_matrix_game => {"1" => {:weight => "1"}, "2" => {:weight => "3"}},
          :symmetric_function_game => {"1" => {:weight => "10"}, "3" => {:weight => "5"}}
        assigns[:games].should == symmetric_function_games + two_player_matrix_games
      end

      it "re-renders the 'probabilities' template" do
        two_player_matrix_games = [mock_model(TwoPlayerMatrixGame, :valid? => false), mock_model(TwoPlayerMatrixGame, :valid? => true)]
        symmetric_function_games = [mock_model(SymmetricFunctionGame, :valid? => true), mock_model(SymmetricFunctionGame, :valid? => true)]
        TwoPlayerMatrixGame.stub(:update).and_return(two_player_matrix_games)
        SymmetricFunctionGame.stub(:update).and_return(symmetric_function_games)
        put :update_probabilities, :two_player_matrix_game => {"1" => {:weight => "1"}, "2" => {:weight => "3"}},
          :symmetric_function_game => {"1" => {:weight => "10"}, "3" => {:weight => "5"}}
        response.should render_template('probabilities')
      end
    end    
  end
  
  describe "GET inactive" do
    it "assigns all inactive games as @games" do
      symmetric_function_games = [mock_model(SymmetricFunctionGame), mock_model(SymmetricFunctionGame)]
      two_player_matrix_games = [mock_model(TwoPlayerMatrixGame), mock_model(TwoPlayerMatrixGame)]
      SymmetricFunctionGame.should_receive(:removed).and_return(symmetric_function_games)
      TwoPlayerMatrixGame.should_receive(:removed).and_return(two_player_matrix_games)
      get :inactive
      assigns[:games].should == symmetric_function_games + two_player_matrix_games
    end
  end
  
  describe "GET activate" do
    it "marks the game as not removed if it is a symmetric function game" do
      symmetric_function_game = mock_model(SymmetricFunctionGame)
      SymmetricFunctionGame.should_receive(:find).with('1').and_return(symmetric_function_game)
      symmetric_function_game.should_receive(:removed=).with(false)
      symmetric_function_game.should_receive(:save)
      get :activate, :id => '1', :type => 'symmetric_function_game'
    end
    it "marks the game as not removed if it is a symmetric function game" do
      two_player_matrix_game = mock_model(TwoPlayerMatrixGame)
      TwoPlayerMatrixGame.should_receive(:find).with('1').and_return(two_player_matrix_game)
      two_player_matrix_game.should_receive(:removed=).with(false)
      two_player_matrix_game.should_receive(:save)
      get :activate, :id => '1', :type => 'two_player_matrix_game'
    end
    
  end
end
