ActionController::Routing::Routes.draw do |map|
  map.resources :two_player_matrix_games, :member => {:statistics => :get}, :except => [:index]
  map.resources :games, :only => [:index]
  map.resources :invitations
  map.resources :cards, :collection => {:played_cards => :get}, :only => [:index, :edit, :destroy, :update], :member => {:result => :get}
  map.resources :symmetric_function_games, :member => {:statistics => :get}, :except => [:index]
  map.resources :researchers, :member => { :remove => :get }, :collection => { :confirm => :get }, :only => [:index, :new, :create]
  map.resources :gifts, 
    :only => [:index], 
    :collection => {:send_money => :post, :receive_money => :get, :money => :get},
    :member => {:card => :get, :send_card => :post, :receive_card => :get}
  map.root :controller => :cards
end
