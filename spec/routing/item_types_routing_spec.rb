require 'spec_helper'

describe ItemTypesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "item_sets/1/item_types" }.should route_to(:controller => "item_types", :action => "index", :item_set_id=>"1")
    end

    it "recognizes and generates #new" do
      { :get => "item_sets/1/item_types/new" }.should route_to(:controller => "item_types", :action => "new", :item_set_id=>"1")
    end

    it "recognizes and generates #show" do
      { :get => "item_sets/1/item_types/2" }.should route_to(:controller => "item_types", :action => "show", :id => "2", :item_set_id=>"1")
    end

    it "recognizes and generates #edit" do
      { :get => "item_sets/1/item_types/2/edit" }.should route_to(:controller => "item_types", :action => "edit", :id => "2", :item_set_id=>"1")
    end

    it "recognizes and generates #create" do
      { :post => "item_sets/1/item_types" }.should route_to(:controller => "item_types", :action => "create", :item_set_id=>"1")
    end

    it "recognizes and generates #update" do
      { :put => "item_sets/1/item_types/2" }.should route_to(:controller => "item_types", :action => "update", :id => "2", :item_set_id=>"1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "item_sets/1/item_types/2" }.should route_to(:controller => "item_types", :action => "destroy", :id => "2", :item_set_id=>"1")
    end
  end
end
