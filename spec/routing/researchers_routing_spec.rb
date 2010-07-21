require 'spec_helper'

describe ResearchersController do
  describe "routing" do
    it "recognizes and generates #confirm" do
      { :get => "/researchers/confirm" }.should route_to(:controller => "researchers", :action => "confirm") 
    end

    it "recognizes and generates #remove" do
      { :get => "/researchers/1/remove" }.should route_to(:controller => "researchers", :action => "remove", :id => "1") 
    end
    
    it "recognizes and generates #index" do
      { :get => "/researchers" }.should route_to(:controller => "researchers", :action => "index")
    end
    
    it "recognizes and generates #new" do
      { :get => "/researchers/new" }.should route_to(:controller => "researchers", :action => "new")
    end
    
    it "should not recognize #edit" do
      { :get => "/researchers/1/edit" }.should_not be_routable
    end
    
    it "recognizes and generates #create" do
      { :post => "/researchers" }.should route_to(:controller => "researchers", :action => "create")
    end
    
    it "should not recognize #update" do
      { :put => "/researchers/1" }.should_not be_routable
    end

    it "should not recognize #show" do
      { :get => "/researchers/1" }.should_not be_routable
    end

    it "should not recognize #destroy" do
      { :delete => "/researchers/1" }.should_not be_routable
    end
  end
end
