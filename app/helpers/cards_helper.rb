module CardsHelper
  
  def filter_payoff(card)
    card.payoff || "Not calculated yet"
  end
  
end
