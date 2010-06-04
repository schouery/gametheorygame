class User < ActiveRecord::Base
  has_many :cards

  def self.for(facebook_id)
    User.find_or_create_by_facebook_id(facebook_id)
  end
  
end
