class ApplicationController < ActionController::Base
  #Include all helpers
  helper :all
  #Prevent some attacks
  protect_from_forgery
  #Make sure that the user is logged in on Facebook
  ensure_authenticated_to_facebook
  #Facebook doesn't allow to friends of the user to be logged
  filter_parameter_logging :fb_sig_friends
  #Accessor for the current user using the system
  attr_accessor :current_user
  #Define the current user before everything
  before_filter :set_current_user
  #Allow helpers and views to use current_user and facebook_session methods
  helper_attr :current_user, :facebook_session
  # Used to define current_user as the user from the facebook session
  def set_current_user
    self.current_user = User.for(facebook_session.user.to_i)
  end
end
