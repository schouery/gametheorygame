ActionController::Routing::Routes.draw do |map|
  map.root :controller => :cards
  map.resources :cards, :only => [:index, :show, :destroy]
  map.resources :symmetric_function_games
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
