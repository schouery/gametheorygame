class CardDealer

  def deal
    User.find(:all).each do |user|
      deal_for(user) if user.hand_size < Configuration[:hand_limit]
    end
  end

  def deal_for(user)
    game = select_game
    number = rand(game.number_of_players) + 1
    Card.create(:user => user, :game => game, :player_number => number)
  end  
    
  def select_game
    @games ||= SymmetricFunctionGame.find(:all, :conditions => {:removed => false}) + 
               TwoPlayerMatrixGame.find(:all, :conditions => {:removed => false})
    weight_sum = @games.inject(0) { |acc, game| acc += game.weight }
    result = rand(weight_sum)
    @games.find {|game| (result -= game.weight) < 0}
  end
      
end