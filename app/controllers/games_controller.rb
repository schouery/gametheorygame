class GamesController < ApplicationController
  def index
    @games = TwoPlayerMatrixGame.find(:all) + SymmetricFunctionGame.find(:all)
    @controllers = {}
    @games.each do |game|
      @controllers[game] = (game.class.to_s.pluralize + "Controller").underscore.to_sym
    end
  end
end
