#Controller used to show user's rankings
class RankingsController < ApplicationController

  #Lists the users ordered by score as @users and the all system's game as
  #@games
  def index
    @users = User.ordered_by_score
    @games = Games.collect_results {|specific_games| specific_games.not_removed}
  end

  #Assings the requested game as @game and the game_scores sorted as
  #@game_scores
  def show
    @game = GameScore.new(:game_id => params[:id],
      :game_type => params[:game_type]).game
    @game_scores = GameScore.sorted(params[:id], params[:game_type])
  end

end
