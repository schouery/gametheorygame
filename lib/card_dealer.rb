class CardDealer

  def deal
    User.find(:all).each do |user|
      Card.create(:user => user, :game => select_game) if user.cards.size < Configuration[:hand_limit]
    end
  end
    
  def select_game
    @games ||= SymmetricFunctionGame.find(:all, :conditions => {:removed => false}) + 
               TwoPlayerMatrixGame.find(:all, :conditions => {:removed => false})
    weight_sum = @games.inject(0) { |acc, game| acc += game.weight }
    result = rand(weight_sum)
    @games.find {|game| (result -= game.weight) < 0}
  end
      
end