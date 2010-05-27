class SymmetricFunctionGamesController < ApplicationController
  def index
    @symmetric_function_games = SymmetricFunctionGame.all
  end

  def show
    @symmetric_function_game = SymmetricFunctionGame.find(params[:id])
  end

  def new
    @symmetric_function_game = SymmetricFunctionGame.new
    2.times { @symmetric_function_game.strategies.build }
  end

  def edit
    @symmetric_function_game = SymmetricFunctionGame.find(params[:id])
  end

  def create
    @symmetric_function_game = SymmetricFunctionGame.new(params[:symmetric_function_game])
    if @symmetric_function_game.save
      flash[:notice] = 'SymmetricFunctionGame was successfully created.'
      redirect_to(@symmetric_function_game)
    else
      render :action => "new"
    end
  end

  def update
    @symmetric_function_game = SymmetricFunctionGame.find(params[:id])
    if @symmetric_function_game.update_attributes(params[:symmetric_function_game])
      flash[:notice] = 'SymmetricFunctionGame was successfully updated.'
      redirect_to(@symmetric_function_game)
    else
      render :action => "edit"
    end
  end

  def destroy
    @symmetric_function_game = SymmetricFunctionGame.find(params[:id])
    @symmetric_function_game.destroy
    redirect_to(symmetric_function_games_url)
  end
  
  def statistics
    @symmetric_function_game = SymmetricFunctionGame.find(params[:id])
  end

end
