#Is the base for items. It contains all information that are shared between
#items of the same type.
class ItemType < ActiveRecord::Base
  belongs_to :item_set
  #On destroy, it festroy all items from this item type
  has_many :items, :dependent => :destroy

  #Creates a hash where the keys are all item sets and the values are empty
  #arrays
  def self.to_hash
    hash = Hash.new
    self.all(:include => :item_set).each do |item_type|
      hash[item_type] = []
    end
    hash
  end
end
