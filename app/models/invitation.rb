class Invitation < ActiveRecord::Base
  def promote(user)
    user.send("#{self.for}=", true)
    user.save
    self.destroy
  end
  
  def self.forbidden(session)
    friends = session.user.friends_with_this_app.map(&:id)
    block = friends.select do |friend|
      yield(User.find(:first, :conditions => {:facebook_id => friend}))
    end.join ','
  end
end
