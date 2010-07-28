#Singleton that saves all the system configurations
class Configuration < ActiveRecord::Base
  #Uses the Acts as Singleton gem to be a singleton
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

  #It allows the use of Configuration[key] shortcut to read a attribute
  def self.[](key)
    instance.read_attribute(key)
  end  
end
