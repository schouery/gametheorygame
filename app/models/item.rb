class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :item_type
  has_one :auction
  named_scope :not_used, :conditions => {:used => false}, :include => :item_type
  
  attr_reader :gift_error
  
  def use
    self.used = true
    self.save
    if self.item_type.item_set.has_full_set(self.user)
      self.item_type.item_set.apply_bonus(self.user)
    end
  end
  
  def can_send_as_gift?(user)
    if self.user != user || self.used
      @gift_error = "You can't send this item!"
      false
    else
      @gift_error = ""
      true
    end
  end
  
  def send_as_gift(user, to_user)
    if can_send_as_gift?(user)
      self.user = nil
      self.gift_for = to_user
      self.save
      return true
    else
      return false
    end
  end
  
  def self.group_by_item_type(user)
    item_types = ItemType.to_hash
    items = Item.find(:all, :conditions => {:user_id => user.id}, :include => {:item_type => :item_set})
    items.each do |item|
      item_types[item.item_type] ||= []
      item_types[item.item_type] << item
    end
    item_types
  end
  
end
