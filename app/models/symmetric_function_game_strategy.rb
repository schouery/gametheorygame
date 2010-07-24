class SymmetricFunctionGameStrategy < ActiveRecord::Base
  validates_presence_of :label
  belongs_to :game, :class_name => "SymmetricFunctionGame", :foreign_key => :game_id
  has_many :cards, :as => :strategy, :dependent => :destroy
end
