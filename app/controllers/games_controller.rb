class GamesController < ApplicationController
  # Lists all games as @games
  def index
    @games = TwoPlayerMatrixGame.find(:all, :conditions => {:removed => false}) +
             SymmetricFunctionGame.find(:all, :conditions => {:removed => false})
    authorize! :read, @games
    @paths = {}
    @games.each do |game|
      @paths[game] = "/" + game.class.to_s.underscore.pluralize + "/"
    end
  end
  
  def inactive
    @games = TwoPlayerMatrixGame.find(:all, :conditions => {:removed => true}) +
             SymmetricFunctionGame.find(:all, :conditions => {:removed => true})
    authorize! :read, @games
  end
  
  def activate
    if params[:type] == 'symmetric_function_game'
      @game = SymmetricFunctionGame.find(params[:id])
    else
      @game = TwoPlayerMatrixGame.find(params[:id])
    end
    @game.removed = false
    @game.save
    redirect_to games_url
  end
    
  def probabilities
    @games = TwoPlayerMatrixGame.find(:all, :conditions => {:removed => false}) +
             SymmetricFunctionGame.find(:all, :conditions => {:removed => false})
    authorize! :update, @games         
  end
  
  def update_probabilities
    game_types = [TwoPlayerMatrixGame, SymmetricFunctionGame]
    game_types.each do |type|
      params[type.to_s.underscore.to_sym].each_pair do |key, hash|
        instance = type.send(:find, key)
        logger.info instance.inspect
        instance.update_attributes(hash)
      end
    end
    redirect_to(games_url)
  end
  
end
