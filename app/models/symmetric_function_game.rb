class SymmetricFunctionGame < ActiveRecord::Base
  validates_presence_of :name, :description, :function, :label_1, :label_2, :color, :number_of_players
  validates_numericality_of :number_of_players, :only_integer => true, :greater_than => 0
  validates_inclusion_of :color, :in => ["red", "green", "yellow"]
end
