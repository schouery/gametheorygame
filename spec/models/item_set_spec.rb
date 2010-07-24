require 'spec_helper'

describe ItemSet do
  it { should have_many(:item_types) }

  before(:each) do
    @item_sets = [mock_model(ItemSet), mock_model(ItemSet)]
    @item_types = [mock_model(ItemType, :item_set => @item_sets[0]),
      mock_model(ItemType, :item_set => @item_sets[0]),
      mock_model(ItemType, :item_set => @item_sets[1]),
      mock_model(ItemType, :item_set => @item_sets[1])]
    @items = [mock_model(Item, :item_type => @item_types[0]),
      mock_model(Item, :item_type => @item_types[0]),
      mock_model(Item, :item_type => @item_types[1]),
      mock_model(Item, :item_type => @item_types[2]),
      mock_model(Item, :item_type => @item_types[2]),
      mock_model(Item, :item_type => @item_types[3])]
    @user = mock_model(User, :id => 1)
  end

  it "creates a hash with item types and items for a user" do
    items = [@items[0], @items[1], @items[2]]
    item_set = ItemSet.new(:id => 1, :item_types => [@item_types[0], @item_types[1]])
    Item.should_receive(:find).with(:all, :conditions => ['user_id = ? AND item_types.item_set_id = ?', @user.id, item_set.id], :include => :item_type).and_return(items)
    item_set.items_for(@user).should == {@item_types[0] => [@items[0], @items[1]], @item_types[1] => [@items[2]]}
  end

  it "creates a hash with item sets for a user" do    
    Item.should_receive(:find).with(:all, :conditions => {:user_id => @user.id}, :include => {:item_type => :item_set}).and_return(@items)
    ItemSet.sets_for(@user).should == {@item_sets[0] => {@item_types[0] => [@items[0], @items[1]], @item_types[1] => [@items[2]]},
      @item_sets[1] => {@item_types[2] => [@items[3], @items[4]], @item_types[3] => [@items[5]]}}
  end
  
  describe "calculating if the user has a full set" do
    it "return false if at least one of items are missing" do
      item_set = ItemSet.new
      user = mock_model(User, :id => 1)
      item_types = [stub_model(ItemType, :items => []), stub_model(ItemType, :items => []), stub_model(ItemType, :items => [])]
      item_set.item_types = item_types
      item_types[0].items.should_receive(:find).with(:first, :conditions => {:user_id => user.id, :used => true}).and_return(mock_model(Item))
      item_types[1].items.should_receive(:find).with(:first, :conditions => {:user_id => user.id, :used => true}).and_return(mock_model(Item))
      item_types[2].items.should_receive(:find).with(:first, :conditions => {:user_id => user.id, :used => true}).and_return(nil)
      item_set.has_full_set(user).should be_false
    end
    it "return true if all items are present" do
      item_set = ItemSet.new
      user = mock_model(User, :id => 1)
      item_types = [stub_model(ItemType, :items => []), stub_model(ItemType, :items => []), stub_model(ItemType, :items => [])]
      item_set.item_types = item_types
      item_types[0].items.should_receive(:find).with(:first, :conditions => {:user_id => user.id, :used => true}).and_return(mock_model(Item))
      item_types[1].items.should_receive(:find).with(:first, :conditions => {:user_id => user.id, :used => true}).and_return(mock_model(Item))
      item_types[2].items.should_receive(:find).with(:first, :conditions => {:user_id => user.id, :used => true}).and_return(mock_model(Item))
      item_set.has_full_set(user).should be_true
    end
  end
  
  it "knows how to apply a bonus" do
    item_set = ItemSet.new
    item_set.bonus_type = "some_kind_of_bonus"
    user = mock_model(User, :some_kind_of_bonus => 2)
    user.should_receive(:some_kind_of_bonus=).with(3)
    user.should_receive(:save)
    item_set.apply_bonus(user)
  end

end
