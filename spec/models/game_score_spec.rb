require 'spec_helper'

describe GameScore do
  it { should belong_to(:user)}
  it { should belong_to(:game, :polymorphic => true) }
end
