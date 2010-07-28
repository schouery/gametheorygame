ADMIN_ID = 1542875245
[User, SymmetricFunctionGame, SymmetricFunctionGameStrategy, TwoPlayerMatrixGame, TwoPlayerMatrixGameStrategy, TwoPlayerMatrixGamePayoff,
  SymmetricFunctionGameStrategy, Card, GameResult, Invitation, MoneyGift, ItemSet, ItemType, Item].each do |table|
  puts "Deleting #{table.to_s}"
  table.delete_all
end

puts "Creating Games"
games = []

election_2 = SymmetricFunctionGame.create!(
  :name => "Election Game for 3 player and 2 candidates", 
  :description => "In this game, you can vote in candidate A or candidate B in a election. If you vote in
  the winner (that is, the candidate with most votes), then you will receive $10, but you vote for
  the looser, you don't gain anything.",
  :number_of_players => 3,
  :color => "red",
  :function => "(st[0] == 1 && np[0] > np[1]) || (st[1] == 1 && np[1] > np[0]) ? 10 : 0"
)

cA = SymmetricFunctionGameStrategy.create!(:label => "Candidate A", :game => election_2)
cB = SymmetricFunctionGameStrategy.create!(:label => "Candidate B", :game => election_2)
games << election_2

polution_game = SymmetricFunctionGame.create!(
  :name => "Polution Game", 
  :description => "This is the Polution Game for 4 players, you can choose to polute or not. Every player pays
  the number of poluting players and a aditional fee of 3 if you choose to not polute. For example, two players
  decide to polute and the other decide to not polute. Then the players that decided to polute pays 2 and the players
  that decided to not polute pays 5.",
  :number_of_players => 4,
  :color => "red",
  :function => "-np[0] - 3*st[1]"
)

polute = SymmetricFunctionGameStrategy.create!(:label => "Polute", :game => polution_game)
not_polute = SymmetricFunctionGameStrategy.create!(:label => "Not Polute", :game => polution_game)
games << polution_game

bs = TwoPlayerMatrixGame.create!(
  :name => "Battle of Sexes",
  :description => "In the Battle of Sexes you have to choose betwen going to watch a soccer match or watch a movie.
  If you are player 1 then you prefer to watch soccer more than watch a movie and 
  if you are player 2 you prefer to watch a movie to watch soccer. But you don't want to go alone, so you 
  would like to go to the same thing than the other player. The matrix represents the possible resuts
  and how much you will gain.",
  :color => "green"
)
s1 = TwoPlayerMatrixGameStrategy.create!(:label => 'Soccer', :player_number => 1, :number => 1)
s2 = TwoPlayerMatrixGameStrategy.create!(:label => 'Movie', :player_number => 1, :number => 2)
s3 = TwoPlayerMatrixGameStrategy.create!(:label => 'Soccer', :player_number => 2, :number => 1)
s4 = TwoPlayerMatrixGameStrategy.create!(:label => 'Movie', :player_number => 2, :number => 2)
bs.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => 6, :payoff_player_2 => 5, :line_position => 0, :column_position => 0)
p2 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => 1, :payoff_player_2 => 1, :line_position => 0, :column_position => 1)
p3 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => 0, :payoff_player_2 => 0, :line_position => 1, :column_position => 0)
p4 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => 5, :payoff_player_2 => 6, :line_position => 1, :column_position => 1)
bs.payoffs = [p1,p2,p3,p4]
bs.save!
games << bs

mp = TwoPlayerMatrixGame.create!(
  :name => "Matching Pennies",
  :description => "You and your opponent will choose between Head or Tail for his coin. Player one wants that both coins
  have the same result and player two wants that the coins have different results.",
  :color => "yellow"
)
s1 = TwoPlayerMatrixGameStrategy.create!(:label => 'Head',  :player_number => 1, :number => 1)
s2 = TwoPlayerMatrixGameStrategy.create!(:label => 'Tails', :player_number => 1, :number => 2)
s3 = TwoPlayerMatrixGameStrategy.create!(:label => 'Head',  :player_number => 2, :number => 1)
s4 = TwoPlayerMatrixGameStrategy.create!(:label => 'Tails', :player_number => 2, :number => 2)
mp.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => 10, :payoff_player_2 => -10, :line_position => 0, :column_position => 0)
p2 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => -10, :payoff_player_2 => 10, :line_position => 0, :column_position => 1)
p3 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => -10, :payoff_player_2 => 10, :line_position => 1, :column_position => 0)
p4 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => 10, :payoff_player_2 => -10, :line_position => 1, :column_position => 1)
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
s1 = TwoPlayerMatrixGameStrategy.create!(:label => 'Confess', :player_number => 1, :number => 1)
s2 = TwoPlayerMatrixGameStrategy.create!(:label => 'Not Confess', :player_number => 1, :number => 2)
s3 = TwoPlayerMatrixGameStrategy.create!(:label => 'Confess', :player_number => 2, :number => 1)
s4 = TwoPlayerMatrixGameStrategy.create!(:label => 'Not Confess', :player_number => 2, :number => 2)
pd.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => -6, :payoff_player_2 => -6, :line_position => 0, :column_position => 0)
p2 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => 0,  :payoff_player_2 => -9, :line_position => 0, :column_position => 1)
p3 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => -9,  :payoff_player_2 => 0, :line_position => 1, :column_position => 0)
p4 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => -3, :payoff_player_2 => -3, :line_position => 1, :column_position => 1)
pd.payoffs = [p1,p2,p3,p4]
pd.save!
games << pd

congestion = TwoPlayerMatrixGame.create!(
  :name => "Congestion Game",
  :description => "You and your opponent have to send your products to the port for shipment. You can choose between two routes: A (the shortest one) or B, but they are easily
  congested, so if and your opponent choose the same route, you both lose more money.",
  :color => "red"
)
s1 = TwoPlayerMatrixGameStrategy.create!(:label => 'A', :player_number => 1, :number => 1)
s2 = TwoPlayerMatrixGameStrategy.create!(:label => 'B', :player_number => 1, :number => 2)
s3 = TwoPlayerMatrixGameStrategy.create!(:label => 'A', :player_number => 2, :number => 1)
s4 = TwoPlayerMatrixGameStrategy.create!(:label => 'B', :player_number => 2, :number => 2)
congestion.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => -5, :payoff_player_2 => -5, :line_position => 0, :column_position => 0)
p2 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => -1, :payoff_player_2 => -2, :line_position => 0, :column_position => 1)
p3 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => -2, :payoff_player_2 => -1, :line_position => 1, :column_position => 0)
p4 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => -6, :payoff_player_2 => -6, :line_position => 1, :column_position => 1)
congestion.payoffs = [p1,p2,p3,p4]
congestion.save!
games << congestion

puts "Creating Items Types and Sets"
houses = [
  ItemType.create!(:name => "Beach House"),
  ItemType.create!(:name => "City House"),
  ItemType.create!(:name => "Country House"),
  ItemType.create!(:name => "Apartment"),
]

ItemSet.create!(:name => "Houses", :item_types => houses, :bonus_type => "cards_per_hour")

cars = [
  ItemType.create!(:name => "Small Car"),
  ItemType.create!(:name => "Medium Car"),
  ItemType.create!(:name => "Large Car"),
  ItemType.create!(:name => "F1 Racing Car")
]

ItemSet.create!(:name => "Cars", :item_types => cars, :bonus_type => "hand_limit")

food_business = [
  ItemType.create!(:name => "Bakery"),
  ItemType.create!(:name => "Coffee Shop"),
  ItemType.create!(:name => "Restaurant"),
  ItemType.create!(:name => "Grocery"),
  ItemType.create!(:name => "Fast Food Shop")
]
ItemSet.create!(:name => "Food Business", :item_types => food_business, :bonus_type => "hand_limit")

technologies = [
  ItemType.create!(:name => "Cell Phone"),
  ItemType.create!(:name => "MP3 Player"),
  ItemType.create!(:name => "Notebook"),
  ItemType.create!(:name => "Desktop Computer"),
  ItemType.create!(:name => "GPS")
]
ItemSet.create!(:name => "Technologies", :item_types => technologies, :bonus_type => "cards_per_hour")

puts "Creating Users"
admin = User.create!(:facebook_id => ADMIN_ID, :admin => true, :researcher => true)#schouery@gmail.com

puts "Setting game ownership to admin"
games.each do |game|
  game.user = admin
  game.save!
end