#Represents a group of item types, when completing a ItemSet the user receives
#a bonus.
class ItemSet < ActiveRecord::Base
  has_many :item_types, :dependent => :destroy

  #Returns a hash where the keys are item types and the values are arrays of
  #items owned by user and which have the specific item type, but it is
  #restricted to item types on this item set
  def items_for(user)
    items = Item.find(:all, :conditions => 
        ['user_id = ? AND item_types.item_set_id = ?', user.id, self.id],
      :include => :item_type)
    item_types = {}
    self.item_types.each do |item_type|
      item_types[item_type] = items.find_all {|item| item.item_type == item_type}
    end
    item_types
  end

  #Returns a hash where the keys are all item sets and the values are hashs like
  #the one returned in items_for
  def self.sets_for(user)
    item_types = Item.group_by_item_type(user)
    item_sets = Hash.new
    item_types.each_pair do |item_type, items|
      item_sets[item_type.item_set] ||= Hash.new
      item_sets[item_type.item_set][item_type] = items
    end  
    item_sets
  end

  #Check to see if the user has this whole set as used items
  def has_full_set(user)
    count = 0
    self.item_types.each do |item_type|
      if !item_type.items.find(:first, :conditions =>
            {:user_id => user.id, :used => true}).nil?
        count += 1
      end      
    end
    count == self.item_types.size
  end

  #Apply a bonus to the user
  def apply_bonus(user)
    current_value = user.send(self.bonus_type)
    user.send("#{self.bonus_type}=", current_value + 1)
    user.save
  end
end