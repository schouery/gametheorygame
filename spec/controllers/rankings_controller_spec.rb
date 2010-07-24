require 'spec_helper'
require 'controllers/controller_stub'

describe RankingsController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
  end
  
  describe "GET index" do
    it "sorts the players by score" do
      players = [stub_model(User), stub_model(User), stub_model(User)]
      User.should_receive(:ordered_by_score).and_return(players)
      get :index
      assigns[:users].should == players
    end
  end

  describe "GET show" do
    it "assigns the users ordered by score" do
      game_scores = [
        stub_model(GameScore, :game_id => 1, :user_id => 1),
        stub_model(GameScore, :game_id => 1, :user_id => 2),
        stub_model(GameScore, :game_id => 1, :user_id => 3)
      ]
      game = mock_model(SymmetricFunctionGame)
      mock_game_score = mock_model(GameScore, :game => game)
      GameScore.should_receive(:new).with(:game_id => "1", :game_type => "symmetric_function_game").and_return(mock_game_score)
      GameScore.should_receive(:sorted).with("1", "symmetric_function_game").and_return(game_scores)
      get :show, :id => 1, :game_type => "symmetric_function_game"
      assigns[:game_scores].should == game_scores
      assigns[:game].should == game
    end
  end

end
