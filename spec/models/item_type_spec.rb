require 'spec_helper'

describe ItemType do
  it { should belong_to(:item_set) }
  it { should have_many(:items)}
end
