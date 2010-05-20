require 'spec_helper'

describe Card do
  it { should belong_to(:user) }
  it { should belong_to(:game, :class_name => "SymmetricFunctionGame") }
  it { should belong_to(:strategy, :class_name => "SymmetricFunctionGameStrategy") }
  it { should have_column(:payoff).type(:integer) }
end
