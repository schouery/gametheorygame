ActionController::Routing::Routes.draw do |map|
  map.resources :two_player_matrix_games, :member => {:statistics => :get}, :except => [:index]
  map.resources :games, :only => [:index]
  map.resources :invitations
  map.resources :cards, :collection => {:played_cards => :get}, :only => [:index, :edit, :destroy, :update]
  map.resources :symmetric_function_games, :member => {:statistics => :get}, :except => [:index]
  map.resources :researchers, :member => { :remove => :get }, :collection => { :confirm => :get }, :only => [:index, :new, :create]
  map.root :controller => :cards
end
