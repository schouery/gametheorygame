class User < ActiveRecord::Base
  def facebook_user 
    @facebook_user_cache ||= Facebooker::User.new(self.facebook_id) 
  end
end
