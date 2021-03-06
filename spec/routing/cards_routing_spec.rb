require 'spec_helper'

describe CardsController do
  describe "routing" do
    it "recognizes and generates #played_cards" do
      { :get => "/cards/played_cards"}.should route_to(:controller => "cards", :action => "played_cards")
    end
    
    it "recognizes and generates #result" do
      { :get => "/cards/1/result"}.should route_to(:controller => "cards", :action => "result", :id => "1")
    end
      
    it "recognizes and generates #index" do
      { :get => "/cards" }.should route_to(:controller => "cards", :action => "index")
    end
    
    it "should not recognize #new" do
      { :get => "/cards/new" }.should_not be_routable
    end
    
    it "recognizes and generates #edit" do
      { :get => "/cards/1/edit" }.should route_to(:controller => "cards", :action => "edit", :id => "1")
    end
    
    it "should not recognize #create" do
      { :post => "/cards" }.should_not be_routable
    end
    
    it "recognizes and generates #update" do
      { :put => "/cards/1" }.should route_to(:controller => "cards", :action => "update", :id => "1")
    end

    it "should not recognize #show" do
      { :get => "/cards/1" }.should_not be_routable
    end

    it "recognizes and generates #discard" do
      { :get => "/cards/1/discard" }.should route_to(:controller => "cards", :action => "discard", :id => "1") 
    end
  end
end
