class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :game, :class_name => "SymmetricFunctionGame"
  belongs_to :strategy, :class_name => "SymmetricFunctionGameStrategy"
end
