# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
#<User id: 1, facebook_id: 1542875245, admin: nil, researcher: nil, created_at: "2010-05-17 20:47:39", updated_at: "2010-05-17 20:47:39">

user = User.create(:facebook_id => 1542875245, :admin => true, :researcher => true)

polution_game = SymmetricFunctionGame.create(:name => "Polution Game for 4", 
:description => "This is Polution Game for 4",
:number_of_players => 4,
:color => "red",
:function => "np[0] + 3*st[1]"
)

polute = SymmetricFunctionGameStrategy.create(:label => "Polute", :symmetric_function_game => polution_game)
not_polute = SymmetricFunctionGameStrategy.create(:label => "Not Polute", :symmetric_function_game => polution_game)

Card.create(:user => user, :symmetric_function_game => polution_game)
Card.create(:user => user, :symmetric_function_game => polution_game)
Card.create(:user => user, :symmetric_function_game => polution_game)
Card.create(:user => user, :symmetric_function_game => polution_game)
