#It represent a item in the system which users should collect to gain bonus.
class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :item_type
  #The item can be on a auction. It will destroy that auction if destroied.
  has_one :auction, :dependent => :destroy
  named_scope :not_used, :conditions => {:used => false}, :include => :item_type

  #Mark the item as used and git the user the bonus if he completed a full set
  def use
    self.used = true
    self.save
    if self.item_type.item_set.has_full_set(self.user)
      self.item_type.item_set.apply_bonus(self.user)
    end
  end

  #Verifies if it can be sended as a gift by the user. The item can be sended as
  #a gift if it belongs to the user and if it was not used
  def can_send_as_gift?(user)
    self.user == user && !self.used
  end

  #Sets gift_for to facebook_id and removes the item from the user. Before all
  #that checks if it can be sended. Returns true if it can be sended and false
  #otherwise.
  def send_as_gift(user, facebook_id)
    if can_send_as_gift?(user)
      self.user = nil
      self.gift_for = facebook_id
      self.save
      return true
    else
      return false
    end
  end


  #Returns a hash where the keys are item_types and the values are arrays of
  #items owned by user and which have the specific item type
  def self.group_by_item_type(user)
    item_types = ItemType.to_hash
    items = Item.find(:all, :conditions => {:user_id => user.id},
      :include => {:item_type => :item_set})
    items.each do |item|
      item_types[item.item_type] ||= []
      item_types[item.item_type] << item
    end
    item_types
  end
  
end
