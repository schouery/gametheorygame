class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, :polymorphic => true
  belongs_to :strategy, :polymorphic => true
  belongs_to :game_result
  after_save :give_money_to_player
  attr_reader :gift_error
  validates_presence_of :strategy, :on => :update
  named_scope :not_played, :conditions => {:played => false}, :include => :game
  named_scope :played, :conditions => {:played => true}, :include => [:strategy, :game]
  named_scope :sorted_by_player_number, :order => :player_number
  named_scope :without_payoff, :conditions => {:payoff => nil}
  
  def give_money_to_player
    if self.payoff
      self.user.money += self.payoff 
      self.user.save
    end
  end
  
  def can_send?
    !self.game.nil? && self.game.color == "green" && !self.played? 
  end

  def can_send_as_gift?(user)
    if self.game.nil? || self.game.color != "green" || self.played? || self.user != user
      @gift_error = "You can't send this card!"
      false
    else
      @gift_error = ""
      true
    end
  end
  
  def send_as_gift(user, to_user)
    if can_send_as_gift?(user)
      self.user = nil
      self.gift_for = to_user
      save
      return true
    else
      return false
    end
  end
  
  def play(payoff)
    self.payoff = payoff
    self.save
    player = self.user
    player.score += payoff
    player.save
    GameScore.update_game_score(self.game, payoff, player)
  end
end
