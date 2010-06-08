require 'spec_helper'

describe Configuration do
  
  before(:each) do
    @config = Configuration.instance
  end

  it "should validate the numericality of money_gift_value" do
    [-1, 0, 1.1, nil, "", "one"].each do |value|
      @config.money_gift_value = value
      @config.should_not be_valid
    end
    [1, 2, "3"].each do |value|
      @config.money_gift_value = value
      @config.should be_valid
    end
  end
  
  it "should have [] acessor" do
    Configuration.should respond_to :[]
    @config.money_gift_value = 10
    @config.save
    Configuration[:money_gift_value].should == 10
  end
end
