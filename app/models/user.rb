class User < ActiveRecord::Base
  has_many :cards

  def self.for(facebook_id)
    User.find_or_create_by_facebook_id(facebook_id)
  end
  
  def max_money_gifts
    if self.money < 0
      0
    else
      self.money / MoneyGift.value_for_gift
    end
  end
  
end
