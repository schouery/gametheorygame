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
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions=>{:removed=>false}).and_return(matrix_games)
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions=>{:removed=>false}).and_return(function_games)
      get :index
      assigns[:games].should == matrix_games + function_games
    end
    
    it "assigns the games paths as @paths" do
      m1, m2 = mock_model(TwoPlayerMatrixGame), mock_model(TwoPlayerMatrixGame)
      matrix_games = [m1,m2]
      f1, f2 = mock_model(SymmetricFunctionGame), mock_model(SymmetricFunctionGame)
      function_games = [f1, f2]
      TwoPlayerMatrixGame.stub(:find => matrix_games)
      SymmetricFunctionGame.stub(:find => function_games)
      get :index
      assigns[:paths].should == {m1 => '/two_player_matrix_games/', m2 => '/two_player_matrix_games/',
        f1 => '/symmetric_function_games/', f2 => '/symmetric_function_games/'}
    end
  end
  
  describe "GET probabilities" do
    it "assigns all games as @games" do
      matrix_games = [mock_model(TwoPlayerMatrixGame), mock_model(TwoPlayerMatrixGame)]
      function_games = [mock_model(SymmetricFunctionGame), mock_model(SymmetricFunctionGame)]
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions=>{:removed=>false}).and_return(matrix_games)
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions=>{:removed=>false}).and_return(function_games)
      get :probabilities
      assigns[:games].should == matrix_games + function_games
    end
  end
  
  describe "PUT update_probabilities" do
    it "saves the games" do
      matrix_game1, matrix_game2 = mock_model(TwoPlayerMatrixGame), mock_model(TwoPlayerMatrixGame)
      function_game1, function_game3 = mock_model(SymmetricFunctionGame), mock_model(SymmetricFunctionGame)
      TwoPlayerMatrixGame.should_receive(:find).with("1").and_return(matrix_game1)
      TwoPlayerMatrixGame.should_receive(:find).with("2").and_return(matrix_game2)
      SymmetricFunctionGame.should_receive(:find).with("1").and_return(function_game1)
      SymmetricFunctionGame.should_receive(:find).with("3").and_return(function_game3)
      matrix_game1.should_receive(:update_attributes).with({"weight" => "1"})
      matrix_game2.should_receive(:update_attributes).with({"weight" => "3"})
      function_game1.should_receive(:update_attributes).with({"weight" => "10"})
      function_game3.should_receive(:update_attributes).with({"weight" => "5"})            
      put :update_probabilities, :two_player_matrix_game => {"1" => {:weight => "1"}, "2" => {:weight => "3"}},
      :symmetric_function_game => {"1" => {:weight => "10"}, "3" => {:weight => "5"}}
      response.should redirect_to games_url
    end
  end
  
  describe "GET inactive" do
    it "assigns all inactive games as @games" do
      symmetric_function_games = [mock_model(SymmetricFunctionGame), mock_model(SymmetricFunctionGame)]
      two_player_matrix_games = [mock_model(TwoPlayerMatrixGame), mock_model(TwoPlayerMatrixGame)]
      SymmetricFunctionGame.should_receive(:find).with(:all, :conditions => {:removed => true}).and_return(symmetric_function_games)
      TwoPlayerMatrixGame.should_receive(:find).with(:all, :conditions => {:removed => true}).and_return(two_player_matrix_games)
      get :inactive
      assigns[:games].should == two_player_matrix_games + symmetric_function_games
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
