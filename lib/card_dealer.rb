class CardDealer

  def deal
    User.find(:all).each do |user|
      user.cards_per_hour.times do
        deal_for(user) if user.hand_size < user.hand_limit
      end
    end
  end

  def deal_for(user)
    if rand <= Configuration[:item_probability]
      item_for(user)
    else
      game_for(user)
    end  
  end  

  def game_for(user)
    game = select_game
    number = rand(game.number_of_players) + 1
    Card.create(:user => user, :game => game, :player_number => number)
  end
    
  def select_game
    games ||= SymmetricFunctionGame.find(:all, :conditions => {:removed => false}) + 
               TwoPlayerMatrixGame.find(:all, :conditions => {:removed => false})
    weight_sum = games.inject(0) { |acc, game| acc += game.weight }
    result = rand(weight_sum)
    games.find {|game| (result -= game.weight) < 0}
  end
  
  def item_for(user)
    item_types = ItemType.all
    item_type = item_types[rand(item_types.size)]
    Item.create(:user => user, :item_type => item_type)
  end
      
end