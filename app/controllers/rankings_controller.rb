class RankingsController < ApplicationController
  
  def index
    @users = User.find(:all, :order => "score DESC")
  end

end
