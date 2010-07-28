#Controller for sending simple invitations
class InvitationsController < ApplicationController

  #Redirects to cards_url.
  #Used only if the user skips the invitation form
  def index
    redirect_to(cards_path)
  end

  #Used to send a invitation. It assigns @exclude_ids as a string with all
  #user's friend's ids that are already players of the game
  def new
    @exclude_ids = facebook_session.
      user.friends_with_this_app.map(&:id).join(",")
  end

  #Informs the user that the invitation was sended and redirects to cards_url
  #bypassing canvas (to avoid nested frames)
  def create
    flash[:notice] = 'Invitation was successfully sended.'
    redirect_to(:action => "index", :controller => "cards", 
      :bypass_canvas => true)
  end

end
