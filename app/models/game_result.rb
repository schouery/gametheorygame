class GameResult < ActiveRecord::Base
  belongs_to :game, :polymorphic => true
  has_many :cards
  
  def sorted_cards
    self.cards.sort_by {|card| card.player_number}
  end
  
end
