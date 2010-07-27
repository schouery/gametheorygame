#Controller for SymmetricFunctionGame
class SymmetricFunctionGamesController < ApplicationController
  #CanCan helper method, assigns @symmetric_function_game in (almost) methods
  load_and_authorize_resource

  #Assigns the requested symmetric function game as @symmetric_function_game
  def show
  end

  #Assigns a new symmetric function game as @symmetric_function_game with two
  #strategies
  def new
    2.times { @symmetric_function_game.strategies.build }
  end

  #Assigns the requested symmetric function game as @symmetric_function_game
  def edit
  end

  #Creates a new SymmetricFunctionGame, set it's owner as current_user and
  #redirects to symmetric_function_game_path(@symmetric_function_game)
  def create
    @symmetric_function_game.user = current_user
    if @symmetric_function_game.save
      flash[:notice] = 'SymmetricFunctionGame was successfully created.'
      redirect_to(@symmetric_function_game)
    else
      render :action => "new"
    end
  end

  #Updates a SymmetricFunctionGame and
  #redirects to symmetric_function_game_path(@symmetric_function_game)
  def update
    if @symmetric_function_game.update_attributes(
        params[:symmetric_function_game])
      flash[:notice] = 'SymmetricFunctionGame was successfully updated.'
      redirect_to(@symmetric_function_game)
    else
      render :action => "edit"
    end
  end

  #Deactivates a SymmetricFunctionGame and redirects to games_path
  def remove  
    authorize! :remove, @symmetric_function_game
    @symmetric_function_game.removed = true
    @symmetric_function_game.save
    redirect_to(games_path)
  end

  #Assigns the requested symmetric function game as @symmetric_function_game
  def statistics
    authorize! :statistics, @symmetric_function_game
  end

end
