class TwoPlayerMatrixGameStrategy < ActiveRecord::Base
  validates_presence_of :label, :player_number
  validates_numericality_of :player_number, :only_integer => true,
    :greater_than => 0, :less_than => 3
  has_many :cards, :as => :strategy, :dependent => :destroy
  belongs_to :game, :class_name => "TwoPlayerMatrixGame",
    :foreign_key => :game_id
end
