require 'spec_helper'

describe ItemsController do
  describe "routing" do
    it "recognizes and generates #use" do
      { :get => "/items/1/use" }.should route_to(:controller => "items", :action => "use", :id => "1")
    end
    
    it "recognizes and generates #index" do
      { :get => "/items" }.should route_to(:controller => "items", :action => "index")
    end

    it "recognizes and generates #show" do
      { :get => "/items/1" }.should route_to(:controller => "items", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/items/1/edit" }.should_not be_routable
    end

    it "recognizes and generates #create" do
      { :post => "/items" }.should_not be_routable
    end

    it "recognizes and generates #update" do
      { :put => "/items/1" }.should_not be_routable
    end

    it "recognizes and generates #destroy" do
      { :delete => "/items/1" }.should_not be_routable
    end
  end
end
