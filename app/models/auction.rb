class Auction < ActiveRecord::Base
  belongs_to :user
  belongs_to :item
  belongs_to :bidder, :class_name => "User", :foreign_key => "bidder_id"
  validates_numericality_of :reserve_price, :only_integer => true, :greater_than_or_equal_to => 0
  validates_numericality_of :bid, :only_integer => true, :greater_than_or_equal_to => 0
  attr_reader :error
  
  def finish
    p self
    if self.bidder.nil?
      self.user.items << self.item
    else
      self.bidder.items << self.item
      self.bidder.save
      self.user.money += self.bid
    end
    self.user.save
    self.destroy
  end

  def self.finish_all
    self.all.each do |auction|
      auction.finish if auction.end_date.past?
    end
  end

  def save_repay
    if !self.bidder.nil?
      @repay_user = self.bidder
      @repay_value = self.bid
    end
  end

  def repay
    if !@repay_user.nil?
      @repay_user.money += @repay_value
      @repay_user.save
    end
  end
  
  def charge
    self.bidder.money -= self.bid
    self.bidder.save
  end

  def can_bid?(value, user)
    @error = if value > user.money
      "Not enough money."
    elsif user == self.user
      "You can't bid on your own auction."
    elsif self.bid >= value
      "You should increase the bid."
    elsif self.end_date.past?
      "This Auction has ended."
    elsif self.reserve_price > value
      "Your bid should be greater or equal to the reserve price."
    else
      nil
    end
    @error.nil?
  end
  
  def make_a_bid(attributes, user)
    self.save_repay
    self.bidder = user
    value = attributes[:bid].to_i
    if can_bid?(value, user) && self.update_attributes(attributes)
      self.repay
      self.charge
      true
    else
      false
    end
  end
  
end
