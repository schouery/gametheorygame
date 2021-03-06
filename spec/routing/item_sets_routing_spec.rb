require 'spec_helper'

describe ItemSetsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/item_sets" }.should route_to(:controller => "item_sets", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/item_sets/new" }.should route_to(:controller => "item_sets", :action => "new")
    end

    it "should not recognize #show" do
      { :get => "/item_sets/1" }.should_not be_routable
    end

    it "recognizes and generates #edit" do
      { :get => "/item_sets/1/edit" }.should route_to(:controller => "item_sets", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/item_sets" }.should route_to(:controller => "item_sets", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/item_sets/1" }.should route_to(:controller => "item_sets", :action => "update", :id => "1") 
    end

    it "should not recognize #destroy" do
      { :delete => "/item_sets/1" }.should_not be_routable
    end

    it "recognizes and generates #delete" do
      { :get => "/item_sets/1/delete" }.should route_to(:controller => "item_sets", :action => "delete", :id => "1") 
    end
    
  end
end
