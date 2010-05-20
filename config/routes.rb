ActionController::Routing::Routes.draw do |map|
  map.root :controller => :cards
  map.resources :cards, :collection => {:played_cards => :get} 
  map.resources :symmetric_function_games
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
