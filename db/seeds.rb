User.delete_all
SymmetricFunctionGame.delete_all
TwoPlayerMatrixGame.delete_all
TwoPlayerMatrixGameStrategy.delete_all
TwoPlayerMatrixGamePayoff.delete_all
SymmetricFunctionGameStrategy.delete_all
Card.delete_all

user = User.create(:facebook_id => 1542875245, :admin => true, :researcher => true)
# 100001128518937 for schouery@ime.usp.br account
polution_game = SymmetricFunctionGame.create(:name => "Polution Game for 4", 
:description => "This is Polution Game for 4",
:number_of_players => 4,
:color => "red",
:function => "np[0] + 3*st[1]"
)

polute = SymmetricFunctionGameStrategy.create(:label => "Polute", :game => polution_game)
not_polute = SymmetricFunctionGameStrategy.create(:label => "Not Polute", :game => polution_game)

Card.create(:user => user, :game => polution_game)
Card.create(:user => user, :game => polution_game)
Card.create(:user => user, :game => polution_game)
Card.create(:user => user, :game => polution_game)

bs = TwoPlayerMatrixGame.create(:name => "Batalha dos Sexos", :description => "BS", :color => "red")
s1 = TwoPlayerMatrixGameStrategy.create(:label => 'S', :player_number => 1)
s2 = TwoPlayerMatrixGameStrategy.create(:label => 'M', :player_number => 1)
s3 = TwoPlayerMatrixGameStrategy.create(:label => 'S', :player_number => 2)
s4 = TwoPlayerMatrixGameStrategy.create(:label => 'M', :player_number => 2)
bs.strategies = [s1,s2,s3,s4]
p1 = TwoPlayerMatrixGamePayoff.create(:strategy1 => s1, :strategy2 => s3, :payoff_player_1 => 6, :payoff_player_2 => 5)
p2 = TwoPlayerMatrixGamePayoff.create(:strategy1 => s1, :strategy2 => s4, :payoff_player_1 => 1, :payoff_player_2 => 1)
p3 = TwoPlayerMatrixGamePayoff.create(:strategy1 => s2, :strategy2 => s3, :payoff_player_1 => 0, :payoff_player_2 => 0)
p4 = TwoPlayerMatrixGamePayoff.create(:strategy1 => s2, :strategy2 => s4, :payoff_player_1 => 5, :payoff_player_2 => 6)
bs.payoffs = [p1,p2,p3,p4]
bs.save

Card.create(:user => user, :game => bs, :player_number => 1)
Card.create(:user => user, :game => bs, :player_number => 2)