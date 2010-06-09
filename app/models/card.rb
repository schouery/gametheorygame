class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, :polymorphic => true
  belongs_to :strategy, :polymorphic => true
  belongs_to :game_result
  after_save :give_money_to_player
  
  def give_money_to_player
    if self.payoff
      self.user.money += self.payoff 
      self.user.save
    end
  end
  
  def played?
    !self.strategy.nil?
  end
  
  def can_send?
    !self.game.nil? && self.game.color == "green" && !played? 
  end
  
end
