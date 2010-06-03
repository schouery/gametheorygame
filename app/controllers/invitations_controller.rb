class InvitationsController < ApplicationController

  def index
    redirect_to(cards_url)
  end

  def new
  end
  
  def create
    flash[:notice] = 'Invitation was successfully sended.'
    redirect_to(cards_url)
  end

end
