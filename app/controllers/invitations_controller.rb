class InvitationsController < ApplicationController

  def index
    redirect_to(cards_url)
  end

  def new
    @exclude_ids = facebook_session.user.friends_with_this_app.map(&:id).join(",")
  end
  
  def create
    flash[:notice] = 'Invitation was successfully sended.'
    redirect_to(cards_url)
  end

end
