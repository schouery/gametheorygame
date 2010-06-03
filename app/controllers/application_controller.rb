# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  ensure_authenticated_to_facebook
  
  filter_parameter_logging :fb_sig_friends

  attr_accessor :current_user
  before_filter :set_current_user
  helper_attr :current_user
  
  def set_current_user
    self.current_user = User.for(facebook_session.user.to_i)
  end

end
