class User < ActiveRecord::Base
  has_many :cards
  has_one :gift_log
  before_save :default_money
  before_save :create_gift_log

  def create_gift_log
    self.gift_log = GiftLog.new if self.gift_log.nil?
  end

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
      money_restriction = self.money / Configuration[:money_gift_value]
      system_restriction = self.gift_log.maximum_gifts_today(:money)
      money_restriction < system_restriction ? money_restriction : system_restriction
    end
  end
  
end
