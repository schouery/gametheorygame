require 'spec_helper'

describe Card do
  it { should belong_to(:user) }
  it { should belong_to(:game, :polymorphic => true) }
  it { should belong_to(:strategy, :polymorphic => true) }
  it { should have_column(:payoff).type(:integer) }
  it { should have_column(:player_number).type(:integer) }
  it { should belong_to(:game_result)}
end
