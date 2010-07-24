class MoneyGift < ActiveRecord::Base
  def self.create_for(users, giver)
    users.each do |id|
      create(:facebook_id => id, :value => Configuration[:money_gift_value])
    end
    giver.money -= users.size * Configuration[:money_gift_value]
    giver.save    
  end
end
