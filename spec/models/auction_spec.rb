require 'spec_helper'

describe Auction do
  it { should belong_to(:user) }
  it { should belong_to(:item) }
  it { should belong_to(:bidder, :class_name => "User", :foreign_key => "bidder_id") }
  it { should validate_numericality_of(:reserve_price).greater_than_or_equal_to(0).only_integer }
  it { should validate_numericality_of(:bid).greater_than_or_equal_to(0).only_integer }
  
  describe "ending a auction" do
    before(:each) do
      @item = mock_model(Item)
      @user = mock_model(User, :items => [], :money => 10)
      @auction = Auction.new(:user => @user, :item => @item)
      @user.should_receive(:save)
      @auction.should_receive(:destroy)
    end
    it "without a bidder" do
      @user.items.should_receive(:<<).with(@item)
      @auction.end
    end
    it "with a bidder" do
      bidder = mock_model(User, :items => [])
      @auction.bidder = bidder
      @auction.bid = 5
      bidder.items.should_receive(:<<).with(@item)
      bidder.should_receive(:save)
      @user.should_receive(:money=).with(15)
      @auction.end
    end
  end
  
  it "knows how to finish all auctions" do
    all_auctions = [mock_model(Auction, :end_date => mock(DateTime, :past? => false)),
                    mock_model(Auction, :end_date => mock(DateTime, :past? => true)),
                    mock_model(Auction, :end_date => mock(DateTime, :past? => false)),
                    mock_model(Auction, :end_date => mock(DateTime, :past? => true))]
    Auction.should_receive(:all).and_return(all_auctions)
    all_auctions[0].should_not_receive(:end)
    all_auctions[1].should_receive(:end)
    all_auctions[2].should_not_receive(:end)
    all_auctions[3].should_receive(:end)
    Auction.finish_all
  end
  
  it "knows how to repay a user" do
    auction = Auction.new
    user = mock_model(User, :money => 5)
    auction.bidder = user
    auction.bid = 10
    auction.save_repay
    user.should_receive(:money=).with(15)
    user.should_receive(:save)
    auction.repay
  end
  
  it "knows how to charge" do
    auction = Auction.new
    user = mock_model(User, :money => 15)
    auction.bidder = user
    auction.bid = 10
    user.should_receive(:money=).with(5)
    user.should_receive(:save)
    auction.charge    
  end
  
  describe "making a bid" do
    before(:each) do
      @auction = Auction.new
      @auction.bidder = @old_bidder = mock_model(User)
      @auction.bid = @old_bid = 10
      @auction.user = @owner = mock_model(User, :money => 100)
      @auction.reserve_price = 0
      @auction.stub(:end_date => mock(DateTime, :past? => false))
      @other_bidder = mock_model(User, :money => 100)
    end
    
    it "can't bid if the bidder doesn't have money" do
      @other_bidder = mock_model(User, :money => 1)
      @auction.can_bid?(@old_bid + 1,@other_bidder).should be_false
    end
    it "can't bid if the item owner and the bidder are the same person" do
      @auction.can_bid?(@old_bid + 1,@owner).should be_false
    end
    it "can't place a smaller bid" do
      @auction.can_bid?(@old_bid-1,@other_bidder).should be_false
      @auction.can_bid?(@old_bid,@other_bidder).should be_false
    end
    it "can't bid in a finished auction" do
      @auction.stub(:end_date => mock(DateTime, :past? => true))
      @auction.can_bid?(@old_bid + 1,@other_bidder).should be_false
    end
    it "can't allow a bid smaller than the reserve price" do
      @auction.reserve_price = 10
      @auction.bid = 0
      @auction.can_bid?(5,@other_bidder).should be_false
    end
    it "otherwise should be able to bid" do
      @auction.can_bid?(@old_bid+1,@other_bidder).should be_true
    end
    
    it "should make a bid if can bid and update" do
      @auction.should_receive(:save_repay)
      @auction.should_receive(:bidder=).with(@other_bidder)
      attributes = {:bid => (@old_bid + 1).to_s}
      @auction.should_receive(:can_bid?).with(@old_bid + 1, @other_bidder).and_return(true)
      @auction.should_receive(:update_attributes).with(attributes).and_return(true)
      @auction.should_receive(:repay)
      @auction.should_receive(:charge)
      @auction.make_a_bid(attributes, @other_bidder).should == true
    end

    it "shouldn't make a bid if it can't bid" do
      @auction.should_receive(:save_repay)
      @auction.should_receive(:bidder=).with(@other_bidder)
      attributes = {:bid => (@old_bid + 1).to_s}
      @auction.should_receive(:can_bid?).with(@old_bid + 1, @other_bidder).and_return(false)
      @auction.make_a_bid(attributes, @other_bidder).should == false
    end
    
    it "shouldn't make a bid if it can't update" do
      @auction.should_receive(:save_repay)
      @auction.should_receive(:bidder=).with(@other_bidder)
      attributes = {:bid => (@old_bid + 1).to_s}
      @auction.should_receive(:can_bid?).with(@old_bid + 1, @other_bidder).and_return(true)
      @auction.should_receive(:update_attributes).with(attributes).and_return(false)
      @auction.make_a_bid(attributes, @other_bidder).should == false
    end
  end
  
end
