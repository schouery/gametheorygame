require 'spec_helper'

describe GiftLog do
  it { should belong_to(:user)}

  before(:each) do
    config = Configuration.instance
    config.money_gift_limit = 5
    config.card_gift_limit = 5
    config.save    
  end
    
  it "should know how many money gifts was sended today" do
    g = GiftLog.new
    cases = [[0, Date.today, 0], [5, Date.today, 5], [5, Date.today - 1, 0]]
    cases.each do |number, date, expected|
      g.number_of_money_gifts = number
      g.money_gift_sent_on = date 
      g.gifts_today(:money).should == expected
    end
    cases.each do |number, date, expected|
      g.number_of_card_gifts = number
      g.card_gift_sent_on = date 
      g.gifts_today(:card).should == expected
    end    
  end
  
  it "should log the gifts sended" do
    g = GiftLog.new
    g.number_of_money_gifts = 0
    g.number_of_card_gifts = 0
    cases = [Date.today, 3, 3],[Date.today, 4, 7],[Date.today-1, 2, 2]
    cases.each do |date, gifts, expected|
      g.money_gift_sent_on = date
      g.log(:money, gifts)
      g.number_of_money_gifts.should == expected
    end
    cases.each do |date, gifts, expected|
      g.card_gift_sent_on = date
      g.log(:card, gifts)
      g.number_of_card_gifts.should == expected
    end
  end
  
  it "should know if it is possible to send n more gifts today" do
    g = GiftLog.new
    g.money_gift_sent_on = Date.today
    g.card_gift_sent_on = Date.today
    cases = [0, 1, true],[4, 1, true],[5, 1, false],[4, 2, false]
    cases.each do |sended, to_send, expected|
      g.number_of_money_gifts = sended
      g.can_send(:money, to_send).should == expected
    end
    cases.each do |sended, to_send, expected|
      g.number_of_card_gifts = sended
      g.can_send(:card, to_send).should == expected
    end
  end
  
  it "should know how many gifts can be sended today" do
    g = GiftLog.new
    g.money_gift_sent_on = Date.today
    g.card_gift_sent_on = Date.today
    cases = [[0,5],[3,2],[6,0]]
    cases.each do |gifts, expected|
      g.number_of_money_gifts = gifts
      g.maximum_gifts_today(:money).should == expected
    end        
    cases.each do |gifts, expected|
      g.number_of_card_gifts = gifts
      g.maximum_gifts_today(:card).should == expected
    end        
  end
  
end
