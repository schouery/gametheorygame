require 'spec_helper'

describe ItemSet do
  it { should have_many(:item_types) }

  it "creates a hash with item types and items for a user" do
    user = mock_model(User, :id => 1)
    itemset = ItemSet.new
    item_types = [mock_model(ItemType, :items => []),
      mock_model(ItemType, :items => []),
      mock_model(ItemType, :items => [])]
    items = [mock_model(Item), nil, mock_model(Item)]
    0.upto(2) do |i|
      item_types[i].items.should_receive(:find).with(:first, :conditions => {:user_id => user.id}).and_return(items[i])
    end
    itemset.item_types = item_types
    itemset.items_for(user).should == {
      item_types[0] => items[0],
      item_types[1] => items[1],
      item_types[2] => items[2]
    }
  end

  it "creates a hash with item sets for a user" do
    user = mock_model(User, :id => 1)
    item_sets = [mock_model(ItemSet), mock_model(ItemSet), mock_model(ItemSet)]
    expected = [mock(Hash), mock(Hash), mock(Hash)]
    ItemSet.should_receive(:all).and_return(item_sets)
    item_sets.each_with_index do |item_set, i|
      item_set.should_receive(:items_for).with(user).and_return(expected[i])
    end
    ItemSet.sets_for(user).should == {
      item_sets[0] => expected[0],
      item_sets[1] => expected[1],
      item_sets[2] => expected[2]
    }
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
