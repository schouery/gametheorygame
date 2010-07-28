#Stores a Invitation that promotes a user to another level
class Invitation < ActiveRecord::Base
  #Promotes the user, using it's field "for" to change a boolean attribute of
  #the user.
  def promote(user)
    user.send("#{self.for}=", true)
    user.save
    self.destroy
  end

  #It runs throw every friend of the user and execute de block that was given.
  #Then It joins all friends that the block retuned true in a comma separeted
  #string.
  def self.forbidden(session)
    friends = session.user.friends_with_this_app.map(&:id)
    block = friends.select do |friend|
      yield(User.find(:first, :conditions => {:facebook_id => friend}))
    end.join ','
  end
end
