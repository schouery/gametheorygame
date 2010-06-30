require 'spec_helper'

describe User do
  it { should have_one(:gift_log)}
  it { should have_many(:cards) }
  it { should have_column(:money).type(:integer) }
  it { should have_column(:score).type(:integer)}

  describe "calculating maximum of money gifts that can be given" do
    before(:each) do
      config = Configuration.instance
      config.money_gift_limit = 20
      config.money_gift_value = 2
      config.save      
      @user = User.new
      @user.gift_log = @gift_log = mock_model(GiftLog)
    end
    
    it "should work without sended gifts today" do
      @gift_log.stub(:maximum_gifts_today).with(:money).and_return(10)
      cases = [[0, 0],[-10,0],[10,5]]
      cases.each do |money, expected|
        @user.money = money
        @user.max_money_gifts.should == expected
      end
    end
    
    it "should work with sended gifts today" do
      @gift_log.stub(:maximum_gifts_today).with(:money).and_return(3)
      cases = [[0, 0],[-10,0],[10,3]]
      cases.each do |money, expected|
        @user.money = money
        @user.max_money_gifts.should == expected
      end
    end
  end
  
  it "should be create with correctly starting money" do
    u = User.new  
    u.stub(:receive_cards => true)
    u.facebook_id = 1
    u.money.should be_nil
    u.save
    u.money.should == Configuration[:starting_money]
    u.money -= 10
    u.save
    u.money.should == Configuration[:starting_money] - 10
  end 

  it "should receive initial cards"
       
end
