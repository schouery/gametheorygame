class GamesController < ApplicationController

  # Lists all games as @games
  def index
    @games = Games.collect_results {|specific_games| specific_games.not_removed }
    authorize! :read, @games
  end
  
  def inactive
    @games = Games.collect_results {|specific_games| specific_games.removed }    
    authorize! :read, @games
  end
  
  def activate
    @game = Games.collect_from_specific_game(params[:type]) do |specific_games|
      specific_games.find(params[:id])
    end
    @game.removed = false
    @game.save
    redirect_to games_url
  end
    
  def probabilities
    @games = Games.collect_results {|specific_games| specific_games.not_removed}
    authorize! :update, @games         
  end
  
  def update_probabilities
    @games = Games.collect_results do |specific_games|
      key = specific_games.to_sym
      specific_games.update(params[key].keys, params[key].values)
    end
    if @games.all? {|game| game.valid?}  
      flash[:notice] = 'Game Weights updated.'
      redirect_to(games_url)
    else
      render 'probabilities'
    end
  end
end
