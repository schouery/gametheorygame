require 'spec_helper'

describe User do
  it { should have_one(:gift_log)}
  it { should have_many(:cards) }
  it { should have_column(:money).type(:integer) }
  it { should have_column(:score).type(:integer)}
  it { should have_many(:game_scores)}
  it { should have_many(:items)}

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
    
    it "should create a gift log automaticaly" do
      u = User.new(:facebook_id => 1)
      u.stub(:defaults => true, :receive_cards => true)
      u.gift_log.should be_nil
      u.save
      u.gift_log.should_not be_nil
    end
  end
  
  it "should be create with correctly defaults" do
    u = User.new  
    u.stub(:receive_cards => true)
    u.facebook_id = 1
    u.money.should be_nil
    u.hand_limit.should be_nil
    u.cards_per_hour.should be_nil
    u.save
    u.money.should == Configuration[:starting_money]
    u.hand_limit.should == Configuration[:starting_hand_limit]
    u.cards_per_hour.should == Configuration[:starting_cards_per_hour]
    u.money -= 1
    u.hand_limit -= 1
    u.cards_per_hour -= 1
    u.save
    u.money.should == Configuration[:starting_money] - 1
    u.hand_limit.should == Configuration[:starting_hand_limit] - 1
    u.cards_per_hour.should == Configuration[:starting_cards_per_hour] - 1
  end 
  
  it "should receive initial cards" do
    config = Configuration.instance
    1.upto(3) do |i|
      config.starting_cards = i
      config.save
      u = User.new(:facebook_id => i)
      mock_card_dealer = mock_model(CardDealer)
      CardDealer.should_receive(:new).and_return(mock_card_dealer)
      mock_card_dealer.should_receive(:deal_for).with(u).exactly(i)
      u.save
    end
  end

  it "knows it's hand size" do
    u = User.new
    u.cards = []
    u.items = []
    u.hand_size.should == 0
    u.cards = [stub_model(Card, :played? => false)]
    u.items = [stub_model(Item, :used => false)]
    u.hand_size.should == 2
    u.cards = [stub_model(Card, :played? => true)]
    u.items = [stub_model(Item, :used => true)]
    u.hand_size.should == 0
    u.cards = [stub_model(Card, :played? => false), mock_model(Card, :played? => true), mock_model(Card, :played? => false)]
    u.items = [stub_model(Item, :used => true), mock_model(Item, :used => false), mock_model(Item, :used => true)]
    u.hand_size.should == 3
  end

end
