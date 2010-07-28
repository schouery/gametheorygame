#Represents a user of the system.
class User < ActiveRecord::Base
  has_many :items
  has_many :cards
  has_many :game_scores
  before_create :defaults  
  after_create :receive_cards 
  named_scope :ordered_by_score, :order => "score DESC"
  named_scope :researchers, :conditions => {:admin => false, :researcher => true}

  #Receive the starting cards
  def receive_cards
    card_dealer = CardDealer.new
    Configuration[:starting_cards].times do 
      card_dealer.deal_for(self)
    end
  end

  #Defines the default values for attribute as given by Configuration
  def defaults
    self.hand_limit = Configuration[:starting_hand_limit] unless self.hand_limit
    self.cards_per_hour = Configuration[:starting_cards_per_hour] unless self.cards_per_hour
    self.money = Configuration[:starting_money] unless self.money
  end

  #Return a user with this facebook_id (creating one if could not find)
  def self.for(facebook_id)
    User.find_or_create_by_facebook_id(facebook_id)
  end

  #Calculates how much money gifts the user can send
  def max_money_gifts
    self.money < 0 ? 0 : self.money / Configuration[:money_gift_value]
  end

  #Calculates the user hand size
  def hand_size
    items = self.items.select {|item| !item.used?}
    cards = self.cards.select {|card| !card.played?}
    items.size + cards.size
  end  
end
