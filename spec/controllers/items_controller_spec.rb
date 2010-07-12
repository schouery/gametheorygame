require 'spec_helper'
require 'controllers/controller_stub'

describe ItemsController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
  end

  def mock_item(stubs = {})
    @mock_item ||= mock_model(Item, stubs)
  end

  def mock_item_type(stubs = {})
    @mock_item_type ||= mock_model(ItemType, stubs)
  end

  def mock_item_set(stubs = {})
    @mock_item_set ||= mock_model(ItemSet, stubs)
  end

  describe "GET index" do
    it "assigns the sets for the user as @user_sets" do
      user_sets = mock(Hash)
      ItemSet.should_receive(:sets_for).with(@current_user).and_return(user_sets)
      get :index
      assigns[:user_sets].should == user_sets
    end
  end

  describe "GET show" do
    it "assigns the item as @item" do
      Item.should_receive(:find).with("1").and_return(mock_item(:item_type => nil))
      get :show, :id => "1"
      assigns[:item].should == mock_item
    end

    it "assigns the item type as @item_type" do
      Item.stub(:find).and_return(mock_item(:item_type => mock_item_type(:item_set => nil)))
      get :show, :id => "1"
      assigns[:item_type].should == mock_item_type
    end

    it "assigns the item set as @item_set" do
      Item.stub(:find).and_return(mock_item(:item_type => mock_item_type(:item_set => mock_item_set)))
      get :show, :id => "1"
      assigns[:item_set].should == mock_item_set
    end
  end

  describe "GET use" do
    it "Uses the item and redirects to cards path" do
      Item.should_receive(:find).with("1").and_return(mock_item)
      mock_item.should_receive(:use)
      get :use, :id => "1"
      response.should redirect_to(cards_path)
    end
  end
  
end
