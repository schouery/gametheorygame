class User < ActiveRecord::Base
  has_many :items
  has_many :cards
  has_many :game_scores
  before_create :defaults  
  after_create :receive_cards 
  named_scope :ordered_by_score, :order => "score DESC"
  named_scope :researchers, :conditions => {:admin => false, :researcher => true}

  def receive_cards
    card_dealer = CardDealer.new
    Configuration[:starting_cards].times do 
      card_dealer.deal_for(self)
    end
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
    self.money < 0 ? 0 : self.money / Configuration[:money_gift_value]
  end

  def hand_size
    items = self.items.select {|item| !item.used?}
    cards = self.cards.select {|card| !card.played?}
    items.size + cards.size
  end  
end
