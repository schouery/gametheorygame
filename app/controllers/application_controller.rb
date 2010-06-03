# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  
  # before_filter :set_facebook_session
  # helper_method :facebook_session

  before_filter :change_to_canvas
  ensure_authenticated_to_facebook
  
  filter_parameter_logging :fb_sig_friends

  attr_accessor :current_user
  before_filter :set_current_user
  helper_attr :current_user
  
  def set_current_user
    self.current_user = User.for(facebook_session.user.to_i)
  end

  def change_to_canvas
    if params[:fb_sig_in_iframe].nil?
      redirect_to "http://apps.facebook.com/" + FACEBOOKER['canvas_page_name'] + url_for(params.merge(:only_path => true))
    end
  end

end
