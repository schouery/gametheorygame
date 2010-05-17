require 'spec_helper'

describe SymmetricFunctionGame do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:function) }
  it { should validate_presence_of(:number_of_players) }
  it { should validate_presence_of(:color) }
  it { should validate_numericality_of(:number_of_players).greater_than(0).only_integer }
  it { should validate_inclusion_of(:color, :in => ["red", "green", "yellow"]) }
  it "should validate that function is a valid ruby function"
  it { should have_many(:strategies, :class_name => "SymmetricFunctionGameStrategy", :dependent => :destroy)}
  it { should accept_nested_attributes_for :strategies }
  it { should have_many(:cards) }
end
