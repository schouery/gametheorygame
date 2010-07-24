class ItemSet < ActiveRecord::Base
  has_many :item_types, :dependent => :destroy

  def items_for(user)
    items = Item.find(:all, :conditions => ['user_id = ? AND item_types.item_set_id = ?', user.id, self.id], :include => :item_type)
    item_types = {}
    self.item_types.each do |item_type|
      item_types[item_type] = items.find_all {|item| item.item_type == item_type}
    end
    item_types
  end
  
  def self.sets_for(user)
    item_types = Item.group_by_item_type(user)
    item_sets = Hash.new
    item_types.each_pair do |item_type, items|
      item_sets[item_type.item_set] ||= Hash.new
      item_sets[item_type.item_set][item_type] = items
    end  
    item_sets
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