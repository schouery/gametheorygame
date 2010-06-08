class Configuration < ActiveRecord::Base
  acts_as_singleton
  validates_numericality_of :money_gift_value, :only_integer => true, :greater_than => 0
  
  def self.[](key)
    instance.read_attribute(key)
  end
  
end
