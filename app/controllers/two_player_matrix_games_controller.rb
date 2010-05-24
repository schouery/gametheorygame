class TwoPlayerMatrixGamesController < ApplicationController
  def index
    @two_player_matrix_games = TwoPlayerMatrixGame.all
  end

  def show
    @two_player_matrix_game = TwoPlayerMatrixGame.find(params[:id])
  end

  def new
    @two_player_matrix_game = TwoPlayerMatrixGame.new
    @two_player_matrix_game.initial_setup
  end

  def edit
    @two_player_matrix_game = TwoPlayerMatrixGame.find(params[:id])
  end

  def create
    @two_player_matrix_game = TwoPlayerMatrixGame.new(params[:two_player_matrix_game])
    @two_player_matrix_game.associate_payoffs
    if @two_player_matrix_game.save
      flash[:notice] = 'TwoPlayerMatrixGame was successfully created.'
      redirect_to(@two_player_matrix_game)
    else
      render :action => "new"
    end
  end

  def update
    @two_player_matrix_game = TwoPlayerMatrixGame.find(params[:id])
    if @two_player_matrix_game.update_attributes(params[:two_player_matrix_game])
      flash[:notice] = 'TwoPlayerMatrixGame was successfully updated.'
      redirect_to(@two_player_matrix_game)
    else
      render :action => "edit"
    end
  end

  def destroy
    @two_player_matrix_game = TwoPlayerMatrixGame.find(params[:id])
    @two_player_matrix_game.destroy
    redirect_to(two_player_matrix_games_url)
  end
end
