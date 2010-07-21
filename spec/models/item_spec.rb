require 'spec_helper'

describe Item do
  it { should belong_to(:user) }
  it { should belong_to(:item_type) }
  it { should have_one(:auction) }
  
  describe "using the item" do
    before(:each) do
      @user = mock_model(User)
      @item = Item.new(:user => @user, :item_type => mock_model(ItemType, :item_set => mock_model(ItemSet)))
      @item.should_receive(:save)      
    end
    
    it "without having a full set" do
      @item.item_type.item_set.should_receive(:has_full_set).with(@user).and_return(false)
      @item.item_type.item_set.should_not_receive(:apply_bonus).with(@user)
    end
    
    it "having a full set" do
      @item.item_type.item_set.should_receive(:has_full_set).with(@user).and_return(true)
      @item.item_type.item_set.should_receive(:apply_bonus).with(@user)
    end
    
    after(:each) do
      @item.use
      @item.used.should be_true      
    end
  end
  
  describe "sending as a gift" do
    before(:each) do
      @item = Item.new
      @gift_log = mock_model(GiftLog)
      @current_user = mock_model(User, :gift_log => @gift_log)
      @gift_log.stub(:maximum_gifts_today).with(:item).and_return(1)
      @item.user = @current_user
    end    
    it "can't be sended if it's not a item from current user" do
      @item.user = mock_model(User)
      @item.can_send_as_gift?(@current_user).should be_false
      @item.gift_error.should == "You can't send this item!"
    end
    it "can't be sended if the maximum for item gifts for today has reached" do
      @gift_log.stub(:maximum_gifts_today).with(:item).and_return(0)
      @item.can_send_as_gift?(@current_user).should be_false
      @item.gift_error.should == "You can't send more items today."
    end
    it "can't be sended if it's used" do
      @item.used = true
      @item.can_send_as_gift?(@current_user).should be_false
      @item.gift_error.should == "You can't send this item!"
    end
    it "otherwise it can be sended" do
      @item.can_send_as_gift?(@current_user).should be_true
      @item.gift_error.should == ""
    end
    
    it "should save the changes on sending" do
      @item.send_as_gift(@current_user, 1).should be_true
      @item.user.should be_nil
      @item.gift_for.should == 1
    end
    
    it "should not save if there is any error" do
      @item.send_as_gift(mock_model(User), 1).should be_false
      @item.user.should == @current_user
      @item.gift_for.should be_nil
      @item.gift_error.should == "You can't send this item!"
    end
  end
end