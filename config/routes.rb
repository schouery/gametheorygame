ActionController::Routing::Routes.draw do |map|
  map.resources :auctions, :except => [:new, :destroy], :member => {:specific => :get}, :collection => {:active => :get}
  map.resources :items, :only => [:index, :show], :member => {:use => :get} do |item|
    item.resources :auctions, :only => [:new]
  end
  map.resources :item_sets, :except => [:destroy, :show], :member => {:delete => :get} do |item_set|
    item_set.resources :item_types, :except => [:destroy, :show], :member => {:delete => :get}
  end
  map.resources :rankings, :only => [:index, :show]
  map.resource  :configuration, :only => [:edit, :update, :show]
  map.resources :two_player_matrix_games, :member => {:statistics => :get, :remove => :get}, :except => [:index, :destroy]
  map.resources :games, :only => [:index], :collection => {:probabilities => :get, :update_probabilities => :post, :inactive => :get}, :member => {:activate => :get}
  map.resources :invitations
  map.resources :cards, :collection => {:played_cards => :get}, :only => [:index, :edit, :update], :member => {:result => :get, :discard => :get}
  map.resources :symmetric_function_games, :member => {:statistics => :get, :remove => :get}, :except => [:index, :destroy]
  map.resources :researchers, :member => { :remove => :get }, :collection => { :confirm => :get }, :only => [:index, :new, :create]
  map.resources :gifts, :only => [:index], 
    :collection => {:send_money => :post, :receive_money => :get, :money => :get},
    :member => {:card => :get, :send_card => :post, :receive_card => :get, :item => :get, :send_item => :post, :receive_item => :get}
  map.facebook_root '', :controller => :cards
  map.with_options :controller => 'info' do |info|
    info.manual 'manual', :action => 'manual'
    info.admin_manual 'admin_manual', :action => 'admin_manual'
    info.researcher_manual 'researcher_manual', :action => 'researcher_manual'
  end    
end