class User < ActiveRecord::Base
  has_many :cards

  # def facebook_user 
  #   @facebook_user_cache ||= Facebooker::User.new(self.facebook_id) 
  # end

  def self.for(facebook_id)
    User.find_or_create_by_facebook_id(facebook_id)
  end

end
