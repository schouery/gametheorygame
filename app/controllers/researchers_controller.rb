class ResearchersController < ApplicationController
  def index
    @researchers = User.researchers
    authorize! :read, @researchers
  end

  def new
    authorize! :invite_researcher, User.new
    @exclude_ids = Invitation.forbidden(facebook_session) do |user|
      !user.nil? && (user.admin? || user.researcher?)
    end
  end
  
  def create
    authorize! :invite_researcher, User.new
    @sent_to_ids = params[:ids]
    @sent_to_ids.each do |id|
      Invitation.create(:facebook_id => id, :for => 'researcher')
    end
    redirect_to(cards_url)
  end
  
  def confirm
    invitation = Invitation.find(:first, :conditions => {:facebook_id => current_user.facebook_id, :for => 'researcher'})
    invitation.promote(current_user)
    flash[:notice] = 'You are now a Researcher!'
    redirect_to(cards_url)
  end
  
  def remove
    @user = User.find(params[:id])
    authorize! :remove_researcher, @user
    @user.researcher = false
    @user.save
    if current_user == @user
      redirect_to(cards_url)
    else
      redirect_to(researchers_url)
    end
  end
  
end
