class User < ActiveRecord::Base
  has_many :cards
  before_save :default_money

  def default_money
    self.money = Configuration[:starting_money] unless self.money
  end

  def self.for(facebook_id)
    User.find_or_create_by_facebook_id(facebook_id)
  end
  
  def max_money_gifts
    if self.money < 0
      0
    else
      self.money / Configuration[:money_gift_value]
    end
  end
  
end
