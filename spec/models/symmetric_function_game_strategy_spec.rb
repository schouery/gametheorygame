require 'spec_helper'

describe SymmetricFunctionGameStrategy do
  it { should belong_to(:symmetric_function_game) }
  it { should validate_presence_of(:label) }
end
