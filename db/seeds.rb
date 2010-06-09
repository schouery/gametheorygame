User.delete_all
SymmetricFunctionGame.delete_all
TwoPlayerMatrixGame.delete_all
TwoPlayerMatrixGameStrategy.delete_all
TwoPlayerMatrixGamePayoff.delete_all
SymmetricFunctionGameStrategy.delete_all
Card.delete_all

admin = User.create!(:facebook_id => 1542875245, :admin => true, :researcher => true)#schouery@gmail.com
researcher = User.create!(:facebook_id => 100001128518937, :admin => false, :researcher => false)#schouery@ime.usp.br

polution_game = SymmetricFunctionGame.create!(:name => "Polution Game", 
:description => "This is the Polution Game for 4 players, you can choose to polute or not. Every player pays
the number of poluting players and a aditional fee of 3 if you choose to not polute.",
:number_of_players => 4,
:color => "red",
:function => "-np[0] - 3*st[1]",
:user => admin
)
polute = SymmetricFunctionGameStrategy.create!(:label => "Polute", :game => polution_game)
not_polute = SymmetricFunctionGameStrategy.create!(:label => "Not Polute", :game => polution_game)

Card.create!(:user => admin, :game => polution_game)
Card.create!(:user => admin, :game => polution_game)
Card.create!(:user => admin, :game => polution_game)
Card.create!(:user => admin, :game => polution_game)

bs = TwoPlayerMatrixGame.create!(:name => "Battle of Sexes",
:description => "In the Battle of Sexes you have to choose betwen going to watch a soccer game or watch a movie.
If you are player 1 then you prefer soccer to movie and if you are player 2 you prefer movie to soccer. But you
would like to go to watch the same thing than the other player.",
:color => "green", 
:user => admin)

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

Card.create!(:user => admin, :game => bs, :player_number => 1)
Card.create!(:user => admin, :game => bs, :player_number => 2)

mp = TwoPlayerMatrixGame.create!(:name => "Matching Pennies",
:description => "As player one, you want both the coins to have the same result, as player two you want that the coins
have different results.",
:color => "yellow", 
:user => researcher)
s1 = TwoPlayerMatrixGameStrategy.create!(:label => 'Head', :player_number => 1)
s2 = TwoPlayerMatrixGameStrategy.create!(:label => 'Tails', :player_number => 1)
s3 = TwoPlayerMatrixGameStrategy.create!(:label => 'Head', :player_number => 2)
s4 = TwoPlayerMatrixGameStrategy.create!(:label => 'Tails', :player_number => 2)
mp.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => 1, :payoff_player_2 => -1)
p2 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => -1, :payoff_player_2 => 1)
p3 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => -1, :payoff_player_2 => 1)
p4 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => 1, :payoff_player_2 => -1)
mp.payoffs = [p1,p2,p3,p4]
mp.save!

Card.create!(:user => admin, :game => mp, :player_number => 1)
Card.create!(:user => researcher, :game => mp, :player_number => 2)

pd = TwoPlayerMatrixGame.create!(:name => "Prisionner's Dilemma",
:description => "The standard prissioner's dilemma.",
:color => "red", 
:user => researcher)
s1 = TwoPlayerMatrixGameStrategy.create!(:label => 'Confess', :player_number => 1)
s2 = TwoPlayerMatrixGameStrategy.create!(:label => 'Not Confess', :player_number => 1)
s3 = TwoPlayerMatrixGameStrategy.create!(:label => 'Confess', :player_number => 2)
s4 = TwoPlayerMatrixGameStrategy.create!(:label => 'Not Confess', :player_number => 2)
pd.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => 6, :payoff_player_2 => 6)
p2 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => 0, :payoff_player_2 => 9)
p3 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => 9, :payoff_player_2 => 0)
p4 = TwoPlayerMatrixGamePayoff.create!(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => 3, :payoff_player_2 => 3)
pd.payoffs = [p1,p2,p3,p4]
pd.save!