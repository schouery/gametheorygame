#Represents a auction in the system. It stores only the current winning bid and
#bidder, not all the bids made so far.
class Auction < ActiveRecord::Base
  #The owner of the item
  belongs_to :user
  #The item to be auctioned
  belongs_to :item
  #The current winner of the auction
  belongs_to :bidder, :class_name => "User", :foreign_key => "bidder_id"
  #The minimum selling price
  validates_numericality_of :reserve_price, :only_integer => true,
    :greater_than_or_equal_to => 0
  #The current winning bid
  validates_numericality_of :bid, :only_integer => true,
    :greater_than_or_equal_to => 0
  #Error when trying to bid in this auction
  attr_reader :error

  #Ends this bid, assigning the item to the winner if there is any and giving
  #the bid value to user.
  def finish
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

  #Ends all auctions that has a end_date in the past
  def self.finish_all
    self.all.each do |auction|
      auction.finish if auction.end_date.past?
    end
  end

  #Saves the current bidder and bid as @repay_user and @repay_value to repay
  #this bidder later
  def save_repay
    if !self.bidder.nil?
      @repay_user = self.bidder
      @repay_value = self.bid
    end
  end

  #Repays the old bidder
  def repay
    if !@repay_user.nil?
      @repay_user.money += @repay_value
      @repay_user.save
    end
  end

  #Charge the bidder his bid
  def charge
    self.bidder.money -= self.bid
    self.bidder.save
  end

  #Checks if the user can bid this value
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

  #Makes a bid, checking if the bid is possible through can_bid?
  #attributes are the attributes received in the controller for updating this
  #auction and user is the new bidder.
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
