class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :item_type
  has_one :auction
  
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
    elsif user.gift_log.maximum_gifts_today(:item) <= 0
      @gift_error = "You can't send more items today."
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
  
  
end
