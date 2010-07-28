#Represents some amount of money that a user sended to a friend.
class MoneyGift < ActiveRecord::Base
  #Creates MoneyGifts to all ids in facebook_ids and remove the money from
  #giver.
  def self.create_for(facebook_ids, giver)
    facebook_ids.each do |id|
      create(:facebook_id => id, :value => Configuration[:money_gift_value])
    end
    giver.money -= facebook_ids.size * Configuration[:money_gift_value]
    giver.save    
  end
end
