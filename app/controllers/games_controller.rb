#Controller for actions commom to all games types
class GamesController < ApplicationController

  # Lists all games as @games
  def index
    @games = Games.collect_results {|specific_games| specific_games.not_removed}
    authorize! :read, TwoPlayerMatrixGame.new
  end

  # Lists all removed games as @games
  def inactive
    @games = Games.collect_results {|specific_games| specific_games.removed}    
    authorize! :read, TwoPlayerMatrixGame.new
  end

  # Activates a specific game and redirects to games_path
  def activate
    @game = Games.collect_from_specific_game(params[:type]) do |specific_games|
      specific_games.find(params[:id])
    end
    @game.removed = false
    @game.save
    redirect_to games_path
  end

  # Lists all games as @games
  def probabilities
    @games = Games.collect_results {|specific_games| specific_games.not_removed}
    authorize! :update, TwoPlayerMatrixGame.new(:user => current_user)
  end

  #Update the weight of all games and redirects to games_path
  def update_probabilities
    @games = Games.collect_results do |specific_games|
      key = specific_games.to_sym
      specific_games.update(params[key].keys, params[key].values)
    end
    if @games.all? {|game| game.valid?}  
      flash[:notice] = 'Game Weights updated.'
      redirect_to(games_path)
    else
      render 'probabilities'
    end
  end
end
