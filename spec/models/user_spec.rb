require 'spec_helper'

describe User do
  it { should have_one(:gift_log)}
  it { should have_many(:cards) }
  it { should have_column(:money).type(:integer) }
  
  it "should calculate the maximum of gifts that can be given" do
    u = User.new
    MoneyGift.stub(:value_for_gift => 1)
    u.money = 0
    u.max_money_gifts.should == 0
    u.money = -10
    u.max_money_gifts.should == 0
    u.money = 10
    u.max_money_gifts.should == 10
  end
  
  it "should be create with correctly starting money" do
    u = User.new
    u.facebook_id = 1
    u.money.should be_nil
    u.save
    u.money.should == Configuration[:starting_money]
    u.money -= 10
    u.save
    u.money.should == Configuration[:starting_money] - 10
  end 
       
end
