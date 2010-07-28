#Stores the score of a user in a specific game
class GameScore < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, :polymorphic => true
  named_scope :sorted, lambda {|game_id, game_type| {
      :conditions => {:game_id => game_id, :game_type => game_type},
      :order => "score DESC"}}

  #Updates the game score of the player by summing the payoff. If the
  #GameScore doesn't exist for this game and player, then creates one.
  def self.update_game_score(game, payoff, player)
    game_score = game.game_scores.find_by_user_id(player.id)
    if game_score.nil?
      game_score = GameScore.new(:user => player, :game => game)
    end
    game_score.score += payoff
    game_score.save
  end
  
end
