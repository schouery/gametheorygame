class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  ensure_authenticated_to_facebook
  filter_parameter_logging :fb_sig_friends
  attr_accessor :current_user
  before_filter :set_current_user
  helper_attr :current_user, :facebook_session
  
  def set_current_user
    self.current_user = User.for(facebook_session.user.to_i)
  end
end
