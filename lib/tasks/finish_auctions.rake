desc "Finish all expired auctions"
task :finish_auctions => :environment do
  Auction.finish_all
end
