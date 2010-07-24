class GameResult < ActiveRecord::Base
  belongs_to :game, :polymorphic => true
  has_many :cards
end
