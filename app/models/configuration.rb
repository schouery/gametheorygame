class Configuration < ActiveRecord::Base
  acts_as_singleton
  validates_numericality_of :money_gift_value, :only_integer => true,
    :greater_than => 0
  validates_numericality_of :starting_money, :only_integer => true,
    :greater_than => 0
  validates_numericality_of :starting_cards, :only_integer => true,
    :greater_than => 0
  validates_numericality_of :starting_cards_per_hour, :only_integer => true,
    :greater_than => 0
  validates_numericality_of :starting_hand_limit, :only_integer => true,
    :greater_than => 0
  validates_numericality_of :item_probability, :greater_than => 0,
    :less_than => 1

  def self.[](key)
    instance.read_attribute(key)
  end  
end
