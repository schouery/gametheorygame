require 'spec_helper'

describe Configuration do
  
  before(:each) do
    @config = Configuration.instance
  end

  it "should have [] acessor" do
    Configuration.should respond_to :[]
    @config.money_gift_value = 10
    @config.save
    Configuration[:money_gift_value].should == 10
  end

  it "should validate the numericality of money_gift_value" do
    @config.should respond_to :money_gift_value
    should_be_positive_integer(:money_gift_value)
  end

  it "should have boolean field full_permissions_to_researchers" do
    @config.should respond_to :full_permissions_to_researchers
  end
  
  it "should have boolean field researcher_can_invite_researcher" do
    @config.should respond_to :researcher_can_invite_researcher
  end
      
  it "should have starting money" do
    @config.should respond_to :starting_money
    should_be_positive_integer(:starting_money)
  end
    
  it "should have starting cards" do
    @config.should respond_to :starting_cards
    should_be_positive_integer(:starting_cards)
  end

  it "should have item probability" do
    @config.should respond_to :item_probability
    invalid(:item_probability, [0, 1, 'a', nil])
    valid(:item_probability, [0.1, 0.5, 0.9])
  end
  
  it "should have starting cards per hour" do
    @config.should respond_to :starting_cards_per_hour
    should_be_positive_integer(:starting_cards_per_hour)
  end
  
  it "should have starting hand limit" do
    @config.should respond_to :starting_hand_limit
    should_be_positive_integer(:starting_hand_limit)
  end

  def should_be_positive_integer(attribute)
    invalid(attribute, [-1, 0, 1.5, 'a', nil])
    valid(attribute, [1,2,3])
  end

  def invalid(attribute, values)
    values.each do |value|
      @config.send("#{attribute}=", value)
      @config.should_not be_valid
    end    
  end
  
  def valid(attribute, values)
    values.each do |value|
      @config.send("#{attribute}=", value)
      @config.should be_valid
    end    
  end
end
