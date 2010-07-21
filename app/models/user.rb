class User < ActiveRecord::Base
  has_many :items
  has_many :cards
  has_many :game_scores
  has_one :gift_log
  before_create :defaults  
  before_save :create_gift_log
  after_create :receive_cards 

  def receive_cards
    card_dealer = CardDealer.new
    Configuration[:starting_cards].times do 
      card_dealer.deal_for(self)
    end
  end

  def create_gift_log
    self.gift_log = GiftLog.new if self.gift_log.nil?
  end
  
  def defaults
    self.hand_limit = Configuration[:starting_hand_limit] unless self.hand_limit
    self.cards_per_hour = Configuration[:starting_cards_per_hour] unless self.cards_per_hour
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

  def hand_size
    items = self.items.select {|item| !item.used}
    cards = self.cards.select {|card| !card.played?}
    items.size + cards.size
    # 
    # items = self.items.inject(0) {|sum, item| sum += item.used ? 0 : 1}
    # cards = self.cards.inject(0) {|sum, card| sum += card.played? ? 0 : 1}
    # items + cards
  end

  
end
