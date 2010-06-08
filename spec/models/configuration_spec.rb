require 'spec_helper'

describe Configuration do
  it "should have [] acessor" do
    Configuration.should respond_to :[]
    config = Configuration.instance
    config.money_gift_value = 10
    config.save
    Configuration[:money_gift_value].should == 10
  end
end
