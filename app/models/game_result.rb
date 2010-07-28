#Model that joins cards as one result of a game, that is, when some players
#plays a specific game, a GameResult is created to represent this play.
class GameResult < ActiveRecord::Base
  belongs_to :game, :polymorphic => true
  has_many :cards
end
