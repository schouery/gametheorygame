require 'spec_helper'
require 'controllers/controller_stub'

describe ItemSetsController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
  end

  def mock_item_set(stubs={})
    @mock_item_set ||= mock_model(ItemSet, stubs)
  end

  describe "GET index" do
    it "assigns all item_sets as @item_sets" do
      ItemSet.stub(:find).with(:all).and_return([mock_item_set])
      get :index
      assigns[:item_sets].should == [mock_item_set]
    end
  end

  describe "GET show" do
    it "assigns the requested item_set as @item_set" do
      ItemSet.stub(:find).with("37").and_return(mock_item_set)
      get :show, :id => "37"
      assigns[:item_set].should equal(mock_item_set)
    end
  end

  describe "GET new" do
    it "assigns a new item_set as @item_set" do
      ItemSet.stub(:new).and_return(mock_item_set(:bonus_type= => true))
      get :new
      assigns[:item_set].should equal(mock_item_set)
    end
  end

  describe "GET edit" do
    it "assigns the requested item_set as @item_set" do
      ItemSet.stub(:find).with("37").and_return(mock_item_set)
      get :edit, :id => "37"
      assigns[:item_set].should equal(mock_item_set)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created item_set as @item_set" do
        ItemSet.stub(:new).with({'these' => 'params'}).and_return(mock_item_set(:save => true))
        post :create, :item_set => {:these => 'params'}
        assigns[:item_set].should equal(mock_item_set)
      end

      it "redirects to the created item_set" do
        ItemSet.stub(:new).and_return(mock_item_set(:save => true))
        post :create, :item_set => {}
        response.should redirect_to(item_set_url(mock_item_set))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item_set as @item_set" do
        ItemSet.stub(:new).with({'these' => 'params'}).and_return(mock_item_set(:save => false))
        post :create, :item_set => {:these => 'params'}
        assigns[:item_set].should equal(mock_item_set)
      end

      it "re-renders the 'new' template" do
        ItemSet.stub(:new).and_return(mock_item_set(:save => false))
        post :create, :item_set => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested item_set" do
        ItemSet.should_receive(:find).with("37").and_return(mock_item_set)
        mock_item_set.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :item_set => {:these => 'params'}
      end

      it "assigns the requested item_set as @item_set" do
        ItemSet.stub(:find).and_return(mock_item_set(:update_attributes => true))
        put :update, :id => "1"
        assigns[:item_set].should equal(mock_item_set)
      end

      it "redirects to the item_set" do
        ItemSet.stub(:find).and_return(mock_item_set(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(item_set_url(mock_item_set))
      end
    end

    describe "with invalid params" do
      it "updates the requested item_set" do
        ItemSet.should_receive(:find).with("37").and_return(mock_item_set)
        mock_item_set.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :item_set => {:these => 'params'}
      end

      it "assigns the item_set as @item_set" do
        ItemSet.stub(:find).and_return(mock_item_set(:update_attributes => false))
        put :update, :id => "1"
        assigns[:item_set].should equal(mock_item_set)
      end

      it "re-renders the 'edit' template" do
        ItemSet.stub(:find).and_return(mock_item_set(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested item_set" do
      ItemSet.should_receive(:find).with("37").and_return(mock_item_set)
      mock_item_set.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the item_sets list" do
      ItemSet.stub(:find).and_return(mock_item_set(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(item_sets_url)
    end
  end

end
