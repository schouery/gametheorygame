Given /^I am logged in as a Facebook user$/ do
  # Initializer facebooker session
  @integration_session = open_session

  @current_user = User.create! :facebook_id => 1
  @current_user.facebook_user.session = Facebooker::MockSession.create(ENV['FACEBOOK_API_KEY'], ENV['FACEBOOK_SECRET_KEY'])
  @current_user.facebook_user.friends = [ 
    Facebooker::User.new(:id => 2, :name => 'Bob'), 
    Facebooker::User.new(:id => 3, :name => 'Sam')]
  @integration_session.default_request_params.merge!( 
    :fb_sig_user => @current_user.facebook_id, 
    :fb_sig_friends => @current_user.facebook_user.friends.map(&:id).join(',') 
  )
end