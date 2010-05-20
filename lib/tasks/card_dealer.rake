desc "Generate one card for each player"
task :card_dealer => :environment do
  CardDealer.new.deal
end
