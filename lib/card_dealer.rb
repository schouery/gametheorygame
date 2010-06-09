class CardDealer

  def deal
    User.find(:all).each do |user|
      deal_for_user(user)
    end
  end
  
  def deal_for_user(user)
    card = create_card_with(user, select_game)
    user.cards.push card
    user.save    
  end
  
  def select_game
    @games ||= SymmetricFunctionGame.find(:all, :conditions => {:removed => false}) + 
               TwoPlayerMatrixGame.find(:all, :conditions => {:removed => false})
    weight_sum = @games.inject(0) { |acc, game| acc += game.weight }
    result = rand(weight_sum)
    @games.find {|game| (result -= game.weight) < 0}
  end
  
  def create_card_with(user, game)
    card = Card.new
    card.user = user
    card.game = game
    card.save    
    card
  end
    
end