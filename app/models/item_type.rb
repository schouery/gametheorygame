class ItemType < ActiveRecord::Base
  belongs_to :item_set
  has_many :items, :dependent => :destroy
  
  def self.to_hash
    hash = Hash.new
    self.all(:include => :item_set).each do |item_type|
      hash[item_type] = []
    end
    hash
  end
end
