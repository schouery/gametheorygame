require 'spec_helper'

describe GamesController do
  describe "routing" do
          
    it "recognizes and generates #index" do
      { :get => "/games" }.should route_to(:controller => "games", :action => "index")
    end
    
    it "recognizes and generates #new" do
      { :get => "/games/new" }.should_not be_routable
    end
    
    it "recognizes and generates #edit" do
      { :get => "/games/1/edit" }.should_not be_routable
    end
    
    it "recognizes and generates #create" do
      { :post => "/games" }.should_not be_routable
    end
    
    it "recognizes and generates #update" do
      { :put => "/games/1" }.should_not be_routable
    end

    it "recognizes and generates #show" do
      { :get => "/games/1" }.should_not be_routable
    end

    it "recognizes and generates #destroy" do
      { :delete => "/games/1" }.should_not be_routable
    end
  end
end
