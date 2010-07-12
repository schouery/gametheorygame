class SymmetricFunctionGamesController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def new
    2.times { @symmetric_function_game.strategies.build }
  end

  def edit
  end

  def create
    @symmetric_function_game.user = current_user
    if @symmetric_function_game.save
      flash[:notice] = 'SymmetricFunctionGame was successfully created.'
      redirect_to(@symmetric_function_game)
    else
      render :action => "new"
    end
  end

  def update
    if @symmetric_function_game.update_attributes(params[:symmetric_function_game])
      flash[:notice] = 'SymmetricFunctionGame was successfully updated.'
      redirect_to(@symmetric_function_game)
    else
      render :action => "edit"
    end
  end

  def remove  
    authorize! :remove, @symmetric_function_game
    @symmetric_function_game.removed = true
    @symmetric_function_game.save
    redirect_to(games_url)
  end
  
  def statistics
    authorize! :statistics, @symmetric_function_game
  end

end
