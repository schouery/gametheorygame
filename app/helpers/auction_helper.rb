#Helper for Auction's Views
module AuctionHelper
  #Calculates the minimum amount that the user has to bid to be a valid bid.
  def minimum_bid(auction)
    if auction.bid.nil? || auction.reserve_price > auction.bid
      auction.reserve_price
    else
      auction.bid + 1
    end
  end
end