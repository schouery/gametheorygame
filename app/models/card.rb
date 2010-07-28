#Represents a Game Card
class Card < ActiveRecord::Base
  #Owner of the card
  belongs_to :user
  #Game of the card
  belongs_to :game, :polymorphic => true
  #Strategy chosen by the user
  belongs_to :strategy, :polymorphic => true
  #GameResult associated to this card when it was played
  belongs_to :game_result
  #Garantees that the strategy is chosen on playing
  validates_presence_of :strategy, :on => :update
  named_scope :not_played, :conditions => {:played => false}, :include => :game
  named_scope :played, :conditions => {:played => true},
    :include => [:strategy, :game]
  named_scope :sorted_by_player_number, :order => :player_number
  named_scope :without_payoff, :conditions => {:payoff => nil}

  #Verifies if it can be sended. A card can be sended if the game color is
  #green, this card was not played and user is the owner of this card
  def can_send_as_gift?(user)
    self.game.color == "green" && !self.played? && self.user == user
  end

  #Sets gift_for to facebook_id and removes the card from the user. Before all
  #that checks if it can be sended. Returns true if it can be sended and false
  #otherwise.
  def send_as_gift(user, facebook_id)
    if can_send_as_gift?(user)
      self.user = nil
      self.gift_for = facebook_id
      self.save_without_validation
      return true
    else
      return false
    end
  end

  #Plays this card, saving the payoff and updating the score and 
  #the money of the player.
  def play(payoff)
    self.payoff = payoff
    self.save
    player = self.user
    player.score += payoff
    player.money += payoff
    player.save
    GameScore.update_game_score(self.game, payoff, player)
  end
end
