class ResearchersController < ApplicationController
  def index
    @researchers = User.find(:all, :conditions => {:admin => false, :researcher => true})
    authorize! :read, @researchers
  end

  def new
    authorize! :invite_researcher, User.new
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
    if !invitation.nil?
      current_user.researcher = true
      current_user.save
      invitation.destroy
      flash[:notice] = 'You are now a Researcher!'
    else
      flash[:notice] = 'You need a invitation to be a Researcher!'      
    end
    redirect_to(cards_url)
  end
  
  def remove
    @user = User.find(params[:id])
    authorize! :remove_researcher, @user
    @user.researcher = false
    @user.save
    redirect_to(researchers_url)
  end
  
end
