class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, :polymorphic => true
   # :class_name => "SymmetricFunctionGame"
  belongs_to :strategy, :polymorphic => true
  # :class_name => "SymmetricFunctionGameStrategy"
end
