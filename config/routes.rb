ActionController::Routing::Routes.draw do |map|
  map.resources :invitations
  map.resources :cards, :collection => {:played_cards => :get} 
  map.resources :symmetric_function_games
  map.resources :researchers, :member => { :remove => :get }

  map.root :controller => :cards
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
