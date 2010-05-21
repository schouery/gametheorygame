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
    
    it "recognizes and generates #edit" do
      pending
      { :get => "/researchers/1/edit" }.should route_to(:controller => "researchers", :action => "edit", :id => "1")
    end
    
    it "recognizes and generates #create" do
      { :post => "/researchers" }.should route_to(:controller => "researchers", :action => "create")
    end
    
    it "recognizes and generates #update" do
      pending
      { :put => "/researchers/1" }.should route_to(:controller => "researchers", :action => "update", :id => "1")
    end

    it "recognizes and generates #show" do
      pending
      { :get => "/researchers/1" }.should_not be_routable
    end

    it "recognizes and generates #destroy" do
      pending
      { :delete => "/researchers/1" }.should route_to(:controller => "researchers", :action => "destroy", :id => "1") 
    end
  end
end
