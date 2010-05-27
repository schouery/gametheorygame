class InvitationsController < ApplicationController
  def new
  end
  
  def create
    flash[:notice] = 'Invitation was successfully sended.'
    redirect_to(cards_url)
  end

end
