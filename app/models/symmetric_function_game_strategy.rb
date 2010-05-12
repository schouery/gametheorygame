class SymmetricFunctionGameStrategy < ActiveRecord::Base
  validates_presence_of :label
  belongs_to :symmetric_function_game
end
