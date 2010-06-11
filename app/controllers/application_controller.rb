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
  
  before_filter :url
  
  def url
    logger.info "\n"*5 + request.inspect + "\n"*5
    # matcher = Regexp.new(FACEBOOKER['callback_url'])
    # if !params['next'].nil? && params['next'] =~ matcher
    #   params['next'].gsub!(matcher, "http://apps.facebook.com/" + FACEBOOKER['canvas_page_name'])
    # end
    # if request.env['HTTP_REFERER'].nil?
    #   #redirect_to
    #   logger.info "URL will redirect to: http://apps.facebook.com/" + FACEBOOKER['canvas_page_name'] + url_for(params.merge({:only_path => true}))
    # end
  end

end
