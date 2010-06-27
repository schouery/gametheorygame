ActionController::Routing::Routes.draw do |map|
  map.resource :configuration, :only => [:edit, :update, :show]
  map.resources :two_player_matrix_games, :member => {:statistics => :get, :remove => :get}, :except => [:index, :destroy]
  map.resources :games, :only => [:index], :collection => {:probabilities => :get, :update_probabilities => :post}
  map.resources :invitations
  map.resources :cards, :collection => {:played_cards => :get}, :only => [:index, :edit, :update], :member => {:result => :get, :discard => :get}
  map.resources :symmetric_function_games, :member => {:statistics => :get, :remove => :get}, :except => [:index, :destroy]
  map.resources :researchers, :member => { :remove => :get }, :collection => { :confirm => :get }, :only => [:index, :new, :create]
  map.resources :gifts, :only => [:index], 
    :collection => {:send_money => :post, :receive_money => :get, :money => :get},
    :member => {:card => :get, :send_card => :post, :receive_card => :get}
  map.root :controller => :cards
  
  map.with_options :controller => 'info' do |info|
    info.manual 'manual', :action => 'manual'
  end
    
end
