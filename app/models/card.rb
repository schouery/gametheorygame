class Card < ActiveRecord::Base
  belongs_to :user
  belongs_to :symmetric_function_game
end
