require 'spec_helper'

describe SymmetricFunctionGameStrategy do
  it { should validate_presence_of(:label) }
  it { should belong_to(:game, :class_name => "SymmetricFunctionGame", :foreign_key => :game_id) }
  it { should have_many(:cards, :as => :strategy)}
end
