class RankingsController < ApplicationController
  
  def index
    @users = User.find(:all, :order => "score DESC")
  end

  def show
    @game_scores = GameScore.find(:all, 
      :conditions => {:game_id => params[:id], :game_type => params[:game_type]},
      :order => "score DESC")
  end

end
