class GameScore < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, :polymorphic => true
end
