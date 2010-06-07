require 'spec_helper'

describe MoneyGift do
  it "responds to value_for_gift" do
    MoneyGift.should respond_to :value_for_gift
  end

end
