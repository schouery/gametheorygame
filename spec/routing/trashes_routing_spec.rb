require 'spec_helper'

describe TrashesController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/trashes" }.should route_to(:controller => "trashes", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/trashes/new" }.should route_to(:controller => "trashes", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/trashes/1" }.should route_to(:controller => "trashes", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/trashes/1/edit" }.should route_to(:controller => "trashes", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/trashes" }.should route_to(:controller => "trashes", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/trashes/1" }.should route_to(:controller => "trashes", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/trashes/1" }.should route_to(:controller => "trashes", :action => "destroy", :id => "1") 
    end
  end
end
