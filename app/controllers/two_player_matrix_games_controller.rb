#Controller for TwoPlayerMatrixGame
class TwoPlayerMatrixGamesController < ApplicationController
  #CanCan helper method, assigns @two_player_matrix_game in (almost) methods
  load_and_authorize_resource

  #Assigns the requested two player matrix game as @two_player_matrix_game
  def show
  end

  #Assigns a new TwoPlayerMatrixGame as @two_player_matrix_game and execute it's
  #initial_setup
  def new
    @two_player_matrix_game.initial_setup
  end


  #Assigns the requested two player matrix game as @two_player_matrix_game
  def edit
  end

  #Create a new TwoPlayerMatrixGame and sets it's owner to current_user and
  #redirects to two_player_matrix_game_path(@two_player_matrix_game)
  def create
    @two_player_matrix_game.user = current_user
    if @two_player_matrix_game.save
      flash[:notice] = 'TwoPlayerMatrixGame was successfully created.'
      redirect_to(@two_player_matrix_game)
    else
      render :action => "new"
    end
  end

  #Updates a TwoPlayerMatrixGame and redirects to
  #two_player_matrix_game_path(@two_player_matrix_game)
  def update
    if @two_player_matrix_game.update_attributes(
        params[:two_player_matrix_game])
      @two_player_matrix_game.associate_payoffs
      @two_player_matrix_game.save
      flash[:notice] = 'TwoPlayerMatrixGame was successfully updated.'
      redirect_to(@two_player_matrix_game)
    else
      render :action => "edit"
    end
  end

  #Deactivates a TwoPlayerMatrixGame and redirects to games_path
  def remove
    authorize! :remove, @two_player_matrix_game
    @two_player_matrix_game.removed = true
    @two_player_matrix_game.save
    redirect_to(games_path)
  end

  #Assigns the requested two player matrix game as @two_player_matrix_game
  def statistics
    authorize! :statistics, @two_player_matrix_game
  end
end