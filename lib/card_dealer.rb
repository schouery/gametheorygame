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
    @games ||= SymmetricFunctionGame.find(:all) + TwoPlayerMatrixGame.find(:all)
    @games[rand(@games.size)]
  end
  
  def create_card_with(user, game)
    card = Card.new
    card.user = user
    card.game = game
    card.save    
    card
  end
    
end