class TwoPlayerMatrixGamesController < ApplicationController
  load_and_authorize_resource

  # def index
  #   @two_player_matrix_games = TwoPlayerMatrixGame.all
  # end

  def show
  end

  def new
    @two_player_matrix_game.initial_setup
  end

  def edit
    @two_player_matrix_game.fill_positions
  end

  def create
    @two_player_matrix_game.user = current_user
    if @two_player_matrix_game.save
      flash[:notice] = 'TwoPlayerMatrixGame was successfully created.'
      redirect_to(@two_player_matrix_game)
    else
      render :action => "new"
    end
  end

  def update
    if @two_player_matrix_game.update_attributes(params[:two_player_matrix_game])
      @two_player_matrix_game.associate_payoffs
      @two_player_matrix_game.save
      flash[:notice] = 'TwoPlayerMatrixGame was successfully updated.'
      redirect_to(@two_player_matrix_game)
    else
      render :action => "edit"
    end
  end

  def destroy
    # @two_player_matrix_game.destroy
    @two_player_matrix_game.removed = true
    @two_player_matrix_game.save
    redirect_to(games_url)
  end
  
  def statistics
    @two_player_matrix_game = TwoPlayerMatrixGame.find(params[:id])
    authorize! :statistics, @two_player_matrix_game
  end
end