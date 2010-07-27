#Helper for Card's Views
module CardsHelper
  #Returns the card's payoff or "Not calculated yet" if the payoff is nil
  def filter_payoff(card)
    card.payoff || "Not calculated yet"
  end
  
end
