class ItemType < ActiveRecord::Base
  belongs_to :item_set
  has_many :items
end
