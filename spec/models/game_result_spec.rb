require 'spec_helper'

describe GameResult do
  it { should belong_to(:game, :polymorphic => true) }
  it { should have_many(:cards) }
end
