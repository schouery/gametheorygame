require 'spec_helper'
require 'controllers/controller_stub'

describe AuctionsController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
  end
  
  def mock_auction(stubs={})
    @mock_auction ||= mock_model(Auction, stubs)
  end
  
  def mock_item(stubs={})
    @mock_item ||= mock_model(Item, stubs)
  end

  def mock_item_type(stubs={})
    @mock_item_type ||= mock_model(ItemType, stubs)
  end
  
  def mock_user(stubs={})
    @mock_user ||= mock_model(User, stubs)
  end

  describe "GET index" do
    it "assigns all auctions as @auctions" do
      all_auctions = [mock_model(Auction, :end_date => mock(DateTime, :future? => false)),
        mock_model(Auction, :end_date => mock(DateTime, :future? => true)),
        mock_model(Auction, :end_date => mock(DateTime, :future? => false))]
      Auction.stub(:find).with(:all).and_return(all_auctions)
      get :index
      assigns[:auctions].should == [all_auctions[1]]
    end
  end

  describe "GET specific" do
    it "assigns all auctions as @auctions" do
      ItemType.should_receive(:find).with("1").and_return(mock_item_type)
      auctions = [mock_model(Auction, :end_date => mock(DateTime, :future? => false)),
        mock_model(Auction, :end_date => mock(DateTime, :future? => true))]
      mock_item_type.stub(:items => [
          mock_model(Item, :auction => auctions[0]),
          mock_model(Item, :auction => auctions[1]),
          mock_model(Item, :auction => nil)])
      get :specific, :id => "1"
      assigns[:auctions].should == [auctions[1]]
      assigns[:item_type].should == mock_item_type
    end
  end

  describe "GET active" do
    it "assigns all auctions as @auctions" do
      all_auctions = [mock_model(Auction, :end_date => mock(DateTime, :future? => false)),
        mock_model(Auction, :end_date => mock(DateTime, :future? => true)),
        mock_model(Auction, :end_date => mock(DateTime, :future? => false))]
      Auction.stub(:find).with(:all, :conditions => {:user_id => @current_user.id}).and_return(all_auctions)
      get :active
      assigns[:auctions].should == [all_auctions[1]]
    end
  end

  
  describe "GET new" do
    it "assigns a new auction as @auction and the item as @item" do
      Item.should_receive(:find).with("1").and_return(mock_item(:auction => nil, :user => @current_user))
      Auction.stub(:new).and_return(mock_auction)
      get :new, :item_id => "1"
      assigns[:auction].should equal(mock_auction)
      assigns[:item].should equal(mock_item)
    end
    
    it "redirects to cards_path if the item can't be auctioned" do
      Item.should_receive(:find).with("1").and_return(mock_item(:auction => mock_auction))
      get :new, :item_id => "1"
      response.should redirect_to cards_path
    end
  end
  
  describe "GET edit" do
    it "assigns the requested auction as @auction" do
      Auction.stub(:find).with("37").and_return(mock_auction)
      get :edit, :id => "37"
      assigns[:auction].should equal(mock_auction)
    end
  end
  
  describe "POST create" do
  
    describe "with valid params" do
      it "assigns a newly created auction as @auction and the item as @item" do
        Auction.stub(:new).with({'these' => 'params'}).and_return(mock_auction(:save => true, :item => mock_item(:user => mock_user)))
        mock_item.should_receive(:user=).with(nil)
        mock_item.should_receive(:save)
        mock_auction.should_receive(:user=).with(mock_user)
        post :create, :auction => {:these => 'params'}
        assigns[:auction].should equal(mock_auction)
        assigns[:item].should == mock_item
      end
  
      it "redirects to the created auction" do
        Auction.stub(:new).and_return(mock_auction(:save => true, :user= => true, :item => mock_item(:user => mock_user, :user= => true, :save => true)))
        post :create, :auction => {}
        response.should redirect_to(cards_path)
      end
    end
  
    describe "with invalid params" do
      it "assigns a newly created but unsaved auction as @auction" do
        Auction.stub(:new).with({'these' => 'params'}).and_return(mock_auction(:save => false, :user= => true, :item => mock_item(:user => mock_user)))
        post :create, :auction => {:these => 'params'}
        assigns[:auction].should equal(mock_auction)
        assigns[:item].should == mock_item
      end
      
      it "re-renders the 'new' template" do
        Auction.stub(:new).and_return(mock_auction(:save => false, :user= => true, :item => mock_item(:user => mock_user)))
        post :create, :auction => {}
        response.should render_template('new')
      end
    end
  
  end
  
  describe "PUT update" do
  
    describe "with valid params" do
      it "makes a bid" do
        Auction.should_receive(:find).with("37").and_return(mock_auction)
        mock_auction.should_receive(:make_a_bid).with({'these' => 'params'}, @current_user).and_return(true)
        put :update, :id => "37", :auction => {:these => 'params'}
      end
  
      it "assigns the requested auction as @auction" do
        Auction.stub(:find).and_return(mock_auction(:make_a_bid => true))
        put :update, :id => "1"
        assigns[:auction].should equal(mock_auction)
      end
  
      it "redirects to the cards path" do
        Auction.stub(:find).and_return(mock_auction(:make_a_bid => true))
        put :update, :id => "1"
        response.should redirect_to(auctions_path)
      end
    end
  
    describe "with invalid params" do
      it "updates the requested auction" do
        Auction.should_receive(:find).with("37").and_return(mock_auction(:error => nil))
        mock_auction.should_receive(:make_a_bid).with({'these' => 'params'}, @current_user).and_return(false)
        put :update, :id => "37", :auction => {:these => 'params'}
      end
  
      it "assigns the auction as @auction" do
        Auction.stub(:find).and_return(mock_auction(:make_a_bid => false, :error => nil))
        put :update, :id => "1"
        assigns[:auction].should equal(mock_auction)
      end
  
      it "re-renders the 'edit' template" do
        Auction.stub(:find).and_return(mock_auction(:make_a_bid => false, :error => "Error"))
        put :update, :id => "1"
        response.should render_template('edit')
        flash[:notice].should == "Error"
      end
    end
  
  end
end
