require 'spec_helper'

describe Card do
  it { should belong_to(:user) }
  it { should belong_to(:symmetric_function_game) }
end
