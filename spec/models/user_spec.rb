require 'spec_helper'

describe User do
  it { should have_many(:cards) }
  it { should have_column(:money).type(:integer) }  
end
