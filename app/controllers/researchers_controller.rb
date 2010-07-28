#Controller for adding or removing researchers
class ResearchersController < ApplicationController

  #Lists all users that are researchers as @researchers
  def index
    @researchers = User.researchers
    authorize! :read, User.new
  end

  #Assigns @exclude_ids as all users that are admins or researchers
  def new
    authorize! :invite_researcher, User.new
    @exclude_ids = Invitation.forbidden(facebook_session) do |user|
      !user.nil? && (user.admin? || user.researcher?)
    end
  end

  #Creates a invitation for researcher to all ids in params[:ids] and redirects
  #to cards_path
  def create
    authorize! :invite_researcher, User.new
    @sent_to_ids = params[:ids]
    @sent_to_ids.each do |id|
      Invitation.create(:facebook_id => id, :for => 'researcher')
    end
    redirect_to(cards_path)
  end

  #Marks the current user as researcher if he has a invitation and redirects to
  #cards_path bypassing canvas (to avoid nested frames)
  def confirm
    invitation = Invitation.find(:first, :conditions => {
        :facebook_id => current_user.facebook_id, :for => 'researcher'})
    invitation.promote(current_user)
    flash[:notice] = 'You are now a Researcher!'
    redirect_to(:action => "index", :controller => "cards", 
      :bypass_canvas => true)
  end

  #Remove the requested user and redirects to cards_path if the current_user
  #requested his removal from researchers lists and redirects to
  #researchers_path if this was done by another user.
  def remove
    @user = User.find(params[:id])
    authorize! :remove_researcher, @user
    @user.researcher = false
    @user.save
    if current_user == @user
      redirect_to(cards_path)
    else
      redirect_to(researchers_path)
    end
  end
  
end
