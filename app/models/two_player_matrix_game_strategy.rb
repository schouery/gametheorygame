class TwoPlayerMatrixGameStrategy < ActiveRecord::Base
  attr_accessor :number
  validates_presence_of :label, :player_number
  validates_numericality_of :player_number, :only_integer => true, :greater_than => 0, :less_than => 3
end
