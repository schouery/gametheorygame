class SymmetricFunctionGamesController < ApplicationController
  # GET /symmetric_function_games
  # GET /symmetric_function_games.xml
  def index
    @symmetric_function_games = SymmetricFunctionGame.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @symmetric_function_games }
    end
  end

  # GET /symmetric_function_games/1
  # GET /symmetric_function_games/1.xml
  def show
    @symmetric_function_game = SymmetricFunctionGame.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @symmetric_function_game }
    end
  end

  # GET /symmetric_function_games/new
  # GET /symmetric_function_games/new.xml
  def new
    @symmetric_function_game = SymmetricFunctionGame.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @symmetric_function_game }
    end
  end

  # GET /symmetric_function_games/1/edit
  def edit
    @symmetric_function_game = SymmetricFunctionGame.find(params[:id])
  end

  # POST /symmetric_function_games
  # POST /symmetric_function_games.xml
  def create
    @symmetric_function_game = SymmetricFunctionGame.new(params[:symmetric_function_game])

    respond_to do |format|
      if @symmetric_function_game.save
        flash[:notice] = 'SymmetricFunctionGame was successfully created.'
        format.html { redirect_to(@symmetric_function_game) }
        format.xml  { render :xml => @symmetric_function_game, :status => :created, :location => @symmetric_function_game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @symmetric_function_game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /symmetric_function_games/1
  # PUT /symmetric_function_games/1.xml
  def update
    @symmetric_function_game = SymmetricFunctionGame.find(params[:id])

    respond_to do |format|
      if @symmetric_function_game.update_attributes(params[:symmetric_function_game])
        flash[:notice] = 'SymmetricFunctionGame was successfully updated.'
        format.html { redirect_to(@symmetric_function_game) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @symmetric_function_game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /symmetric_function_games/1
  # DELETE /symmetric_function_games/1.xml
  def destroy
    @symmetric_function_game = SymmetricFunctionGame.find(params[:id])
    @symmetric_function_game.destroy

    respond_to do |format|
      format.html { redirect_to(symmetric_function_games_url) }
      format.xml  { head :ok }
    end
  end
end
