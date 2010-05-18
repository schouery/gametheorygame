require 'spec_helper'

describe CardsController do
  describe "routing" do
      
    it "recognizes and generates #index" do
      { :get => "/" }.should route_to(:controller => "cards", :action => "index")
    end
    
    it "recognizes and generates #new" do
      pending
      { :get => "/cards/new" }.should_not be_routable
    end
    
    it "recognizes and generates #edit" do
      { :get => "/cards/1/edit" }.should route_to(:controller => "cards", :action => "edit", :id => "1")
    end
    
    it "recognizes and generates #create" do
      pending
      { :post => "/cards" }.should_not be_routable
    end
    
    it "recognizes and generates #update" do
      { :put => "/cards/1" }.should route_to(:controller => "cards", :action => "update", :id => "1")
    end

    it "recognizes and generates #show" do
      pending
      { :get => "/cards/1" }.should_not be_routable
    end

    it "recognizes and generates #destroy" do
      { :delete => "/cards/1" }.should route_to(:controller => "cards", :action => "destroy", :id => "1") 
    end
  end
end
