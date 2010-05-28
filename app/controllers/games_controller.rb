class GamesController < ApplicationController
  def index
    @games = TwoPlayerMatrixGame.find(:all, :conditions => {:removed => false}) +
             SymmetricFunctionGame.find(:all, :conditions => {:removed => false})
    authorize! :read, @games
    @paths = {}
    @games.each do |game|
      @paths[game] = "/" + game.class.to_s.underscore.pluralize + "/"
    end
  end
end
