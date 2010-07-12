[User, SymmetricFunctionGame, SymmetricFunctionGameStrategy, TwoPlayerMatrixGame, TwoPlayerMatrixGameStrategy, TwoPlayerMatrixGamePayoff,
SymmetricFunctionGameStrategy, Card, GameResult, GiftLog, Invitation, MoneyGift, ItemSet, ItemType, Item].each do |table|
  puts "Deleting #{table.to_s}"
  table.delete_all
end

puts "Creating Games"
games = []

polution_game4 = SymmetricFunctionGame.create!(
  :name => "Polution Game for 4 players", 
  :description => "This is the Polution Game for 4 players, you can choose to polute or not. Every player pays
  the number of poluting players and a aditional fee of 3 if you choose to not polute. For example, two players
  decide to polute and the other decide to not polute. Then the players that decided to polute pays 2 and the players
  that decided to not polute pays 5.",
  :number_of_players => 4,
  :color => "red",
  :function => "-np[0] - 3*st[1]"
)

polute4 = SymmetricFunctionGameStrategy.create!(:label => "Polute", :game => polution_game4)
not_polute4 = SymmetricFunctionGameStrategy.create!(:label => "Not Polute", :game => polution_game4)
games << polution_game4

polution_game6 = SymmetricFunctionGame.create!(
  :name => "Polution Game for 6 players", 
  :description => "This is the Polution Game for 6 players, you can choose to polute or not. Every player pays
  the number of poluting players and a aditional fee of 3 if you choose to not polute. For example, two players
  decide to polute and the other decide to not polute. Then the players that decided to polute pays 2 and the players
  that decided to not polute pays 5.",
  :number_of_players => 6,  
  :color => "red",
  :function => "-np[0] - 3*st[1]"
)

polute6 = SymmetricFunctionGameStrategy.create!(:label => "Polute", :game => polution_game6)
not_polute6 = SymmetricFunctionGameStrategy.create!(:label => "Not Polute", :game => polution_game6)
games << polution_game6

bs = TwoPlayerMatrixGame.create!(
  :name => "Battle of Sexes",
  :description => "In the Battle of Sexes you have to choose betwen going to watch a soccer match or watch a movie.
  If you are player 1 then you prefer to watch soccer more than watch a movie and 
  if you are player 2 you prefer to watch a movie to watch soccer. But you don't want to go alone, so you 
  would like to go to the same thing than the other player. The matrix represents the possible resuts
  and how much you will gain.",
  :color => "green"
)
s1 = TwoPlayerMatrixGameStrategy.create!(:label => 'Soccer', :player_number => 1)
s2 = TwoPlayerMatrixGameStrategy.create!(:label => 'Movie', :player_number => 1)
s3 = TwoPlayerMatrixGameStrategy.create!(:label => 'Soccer', :player_number => 2)
s4 = TwoPlayerMatrixGameStrategy.create!(:label => 'Movie', :player_number => 2)
bs.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => 6, :payoff_player_2 => 5)
p2 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => 1, :payoff_player_2 => 1)
p3 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => 0, :payoff_player_2 => 0)
p4 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => 5, :payoff_player_2 => 6)
bs.payoffs = [p1,p2,p3,p4]
bs.save!
games << bs

mp = TwoPlayerMatrixGame.create!(
  :name => "Matching Pennies",
  :description => "You and your opponent will choose between Head or Tail for his coin. Player one wants that both coins
  have the same result and player two wants that the coins have different results.",
  :color => "yellow"
)
s1 = TwoPlayerMatrixGameStrategy.create!(:label => 'Head', :player_number => 1)
s2 = TwoPlayerMatrixGameStrategy.create!(:label => 'Tails', :player_number => 1)
s3 = TwoPlayerMatrixGameStrategy.create!(:label => 'Head', :player_number => 2)
s4 = TwoPlayerMatrixGameStrategy.create!(:label => 'Tails', :player_number => 2)
mp.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => 10, :payoff_player_2 => -10)
p2 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => -10, :payoff_player_2 => 10)
p3 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => -10, :payoff_player_2 => 10)
p4 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => 10, :payoff_player_2 => -10)
mp.payoffs = [p1,p2,p3,p4]
mp.save!
games << mp

pd = TwoPlayerMatrixGame.create!(
  :name => "Prisionner's Dilemma",
  :description => "You and another person commit a crime and the police has found out. You are being interrogated by the police
  and has to choose between confess or not confess. Depending on your strategy and the other player's strategy you will pay a
  certain amount as a fee.",
  :color => "red"
)
s1 = TwoPlayerMatrixGameStrategy.create!(:label => 'Confess', :player_number => 1)
s2 = TwoPlayerMatrixGameStrategy.create!(:label => 'Not Confess', :player_number => 1)
s3 = TwoPlayerMatrixGameStrategy.create!(:label => 'Confess', :player_number => 2)
s4 = TwoPlayerMatrixGameStrategy.create!(:label => 'Not Confess', :player_number => 2)
pd.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => -6, :payoff_player_2 => -6)
p2 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => 0, :payoff_player_2 => -9)
p3 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => -9, :payoff_player_2 => 0)
p4 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => -3, :payoff_player_2 => -3)
pd.payoffs = [p1,p2,p3,p4]
pd.save!
games << pd

puts "Creating Users"
admin = User.create!(:facebook_id => 1542875245, :admin => true, :researcher => true)#schouery@gmail.com
researcher = admin

puts "Setting game ownership"
games.each do |game|
  game.user = admin
  game.save!
end

puts "Creating Items Types and Sets"
houses = [
  ItemType.create!(:name => "Beach House"),
  ItemType.create!(:name => "City House"),
  ItemType.create!(:name => "Country House")
]

ItemSet.create!(:name => "Houses", :item_types => houses, :bonus_type => "cards_per_hour")

cars = [
  ItemType.create!(:name => "Small Car"),
  ItemType.create!(:name => "Medium Car"),
  ItemType.create!(:name => "Large Car"),
  ItemType.create!(:name => "F1 Racing Car")
]

ItemSet.create!(:name => "Cars", :item_types => cars, :bonus_type => "hand_limit")