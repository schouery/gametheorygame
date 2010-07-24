require 'spec_helper'

describe GameScore do
  it { should belong_to(:user)}
  it { should belong_to(:game, :polymorphic => true) }
  
  describe "updating game score" do
    before(:each) do
      @payoff = 15
      @player = mock_model(User, :id => 1)
      @game = TwoPlayerMatrixGame.new
    end
    it "having a game score" do
      initial = 10
      game_score = mock_model(GameScore, :score => initial)
      @game.game_scores.should_receive(:find_by_user_id).with(@player.id).and_return(game_score)
      game_score.should_receive(:score=).with(@payoff + initial)
      game_score.should_receive(:save)
      GameScore.update_game_score(@game, @payoff, @player)
    end
  
    it "without havig a game score" do
      initial = 0  
      game_score = mock_model(GameScore, :score => 0)
      @game.game_scores.should_receive(:find_by_user_id).with(@player.id).and_return(nil)
      GameScore.should_receive(:new).with(:user => @player, :game => @game).and_return(game_score)
      game_score.should_receive(:score=).with(@payoff + initial)
      game_score.should_receive(:save)
      GameScore.update_game_score(@game, @payoff, @player)
    end
  end
  
end
# 
# def self.update_game_score(game, payoff, player)
#   game_score = game.game_scores.find_by_user_id(player.id)
#   if game_score.nil?
#     game_score = GameScore.new(:user => player, :game => game)
#   end
#   game_score.score += payoff
#   game_score.save
# end
