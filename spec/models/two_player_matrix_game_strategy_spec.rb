require 'spec_helper'

describe TwoPlayerMatrixGameStrategy do
  it { should validate_presence_of(:label) }
  it { should validate_presence_of(:player_number) }
  it { should validate_numericality_of(:player_number).greater_than(0).less_than(3).only_integer }  
end
