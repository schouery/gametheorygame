class Configuration < ActiveRecord::Base
  acts_as_singleton
  
  def self.[](key)
    instance.read_attribute(key)
  end
  
end
