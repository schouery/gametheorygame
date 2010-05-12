Factory.define :user do |u|
  u.facebook_id "1"
  u.admin false
  u.researcher false
end

Factory.define :admin, :class => User do |u|
  u.facebook_id "1"
  u.admin true
  u.researcher false
end

Factory.define :reseacher, :class => User do |u|
  u.facebook_id "1"
  u.admin false
  u.researcher false
end

Factory.define :symmetric_function_game do |game|
  game.name "Polution Game for 4"
  game.description "Polution Game, you should choose between polute or not."
  game.number_of_players 4
  game.label_1 "Polute"
  game.label_2 "Not Polute"
  game.color "red"
  game.function "s[1] + p"
end