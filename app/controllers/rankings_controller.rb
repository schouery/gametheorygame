class RankingsController < ApplicationController
  
  def index
    @users = User.ordered_by_score
    @games = Games.collect_results {|specific_games| specific_games.not_removed}
  end

  def show
    @game = GameScore.new(:game_id => params[:id], :game_type => params[:game_type]).game
    @game_scores = GameScore.sorted(params[:id], params[:game_type])
  end

end
