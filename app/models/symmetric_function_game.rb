class SymmetricFunctionGame < ActiveRecord::Base
  validates_presence_of :name, :description, :function, :color, :number_of_players
  validates_numericality_of :number_of_players, :only_integer => true, :greater_than => 0
  validates_inclusion_of :color, :in => ["red", "green", "yellow"]
  has_many :strategies, :class_name => "SymmetricFunctionGameStrategy", :dependent => :destroy
  accepts_nested_attributes_for :strategies
end
