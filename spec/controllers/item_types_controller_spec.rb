require 'spec_helper'
require 'controllers/controller_stub'

describe ItemTypesController do
  include ControllerStub

  before (:each) do
    basic_controller_stub
    ItemSet.stub(:find).and_return(mock_item_set)
  end

  def mock_item_type(stubs={})
    @mock_item_type ||= mock_model(ItemType, stubs)
  end
  
  def mock_item_set(stubs={})
    @mock_item_set ||= mock_model(ItemSet, stubs)
  end

  def find_one(id, item_type)
    item_types = [item_type]
    mock_item_set.stub(:item_types).and_return(item_types)
    item_types.should_receive(:find).with(id).and_return(item_type)
  end

  def build(params = nil)
    item_types = [mock_item_type]
    mock_item_set.stub(:item_types).and_return(item_types)
    if params.nil?
      item_types.should_receive(:build).and_return(mock_item_type)
    else
      item_types.should_receive(:build).with(params).and_return(mock_item_type)
    end
  end

  describe "GET index" do
    it "assigns all item_types as @item_types" do
      mock_item_set.stub(:item_types).and_return([mock_item_type])
      get :index, :item_set_id => "1"
      assigns[:item_types].should == [mock_item_type]
    end
  end

  describe "GET show" do
    it "assigns the requested item_type as @item_type" do
      find_one("37", mock_item_type)
      get :show, :id => "37", :item_set_id => "1"
      assigns[:item_type].should equal(mock_item_type)
    end
  end

  describe "GET new" do
    it "assigns a new item_type as @item_type" do
      build
      get :new, :item_set_id => "1"
      assigns[:item_type].should equal(mock_item_type)
    end
  end

  describe "GET edit" do
    it "assigns the requested item_type as @item_type" do
      find_one("37", mock_item_type)
      get :edit, :id => "37", :item_set_id => "1"
      assigns[:item_type].should equal(mock_item_type)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created item_type as @item_type" do
        build({'these' => 'params'})
        mock_item_type.stub(:save => true)
        post :create, :item_type => {:these => 'params'}, :item_set_id => "1"
        assigns[:item_type].should equal(mock_item_type)
      end

      it "redirects to the created item_type" do
        build
        mock_item_type.stub(:save => true)
        post :create, :item_type => {}, :item_set_id => "1"
        response.should redirect_to(item_set_item_type_url(mock_item_set, mock_item_type))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item_type as @item_type" do
        build('these' => 'params')
        mock_item_type.stub(:save => false)
        post :create, :item_type => {:these => 'params'}, :item_set_id => "1"
        assigns[:item_type].should equal(mock_item_type)
      end

      it "re-renders the 'new' template" do
        build
        mock_item_type.stub(:save => false)
        post :create, :item_type => {}, :item_set_id => "1"
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested item_type" do
        find_one("37", mock_item_type)
        mock_item_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :item_type => {:these => 'params'}, :item_set_id => "1"
      end

      it "assigns the requested item_type as @item_type" do
        find_one("1", mock_item_type(:update_attributes => true))
        put :update, :id => "1", :item_set_id => "1"
        assigns[:item_type].should equal(mock_item_type)
      end

      it "redirects to the item_type" do
        find_one("1", mock_item_type(:update_attributes => true))
        put :update, :id => "1", :item_set_id => "1"
        response.should redirect_to(item_set_item_type_url(mock_item_set, mock_item_type))
      end
    end

    describe "with invalid params" do
      it "updates the requested item_type" do
        find_one("37", mock_item_type)
        mock_item_type.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :item_type => {:these => 'params'}, :item_set_id => "1"
      end

      it "assigns the item_type as @item_type" do
        find_one("1", mock_item_type(:update_attributes => false))
        put :update, :id => "1", :item_set_id => "1"
        assigns[:item_type].should equal(mock_item_type)
      end

      it "re-renders the 'edit' template" do
        find_one("1", mock_item_type(:update_attributes => false))
        put :update, :id => "1", :item_set_id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested item_type" do
      find_one("37", mock_item_type)
      mock_item_type.should_receive(:destroy)
      delete :destroy, :id => "37", :item_set_id => "1"
    end

    it "redirects to the item_types list" do
      find_one("1", mock_item_type(:destroy => true))
      delete :destroy, :id => "1", :item_set_id => "1"
      response.should redirect_to(item_set_item_types_url)
    end
  end

end
