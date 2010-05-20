module CardsHelper
  
  def filter_payoff(card)
    card.payoff ? card.payoff : "Not calculated yet"
  end
  
end
