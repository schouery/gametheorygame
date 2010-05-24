class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, :polymorphic => true
  belongs_to :strategy, :polymorphic => true
    
end
