User.delete_all
SymmetricFunctionGame.delete_all
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
