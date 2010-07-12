class ItemSet < ActiveRecord::Base
  has_many :item_types

  def items_for(user)
    hash = {}
    self.item_types.each do |item_type|
      hash[item_type] = item_type.items.find(:first, :conditions => {:user_id => user.id})
    end
    hash
  end

  def self.sets_for(user)
    hash = {}
    self.all.each do |item_set|
      hash[item_set] = item_set.items_for(user)
    end
    hash
  end
  
  def has_full_set(user)
    count = 0
    self.item_types.each do |item_type|
      if !item_type.items.find(:first, :conditions => {:user_id => user.id, :used => true}).nil?
        count += 1
      end      
    end
    count == self.item_types.size
  end
  
  def apply_bonus(user)
    current_value = user.send(self.bonus_type)
    user.send("#{self.bonus_type}=", current_value + 1)
    user.save
  end
end