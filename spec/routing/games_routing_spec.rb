require 'spec_helper'

describe GamesController do
  describe "routing" do

    it "recognizes and generates #inactive" do
      { :get => "/games/inactive" }.should route_to(:controller => "games", :action => "inactive")
    end
    
    it "recognizes and generates #activate" do
      { :get => "/games/1/activate" }.should route_to(:controller => "games", :action => "activate", :id => '1')
    end
     
    it "recognizes and generates #update_probabilities" do
      { :post => "/games/update_probabilities" }.should route_to(:controller => "games", :action => "update_probabilities")
    end

    it "recognizes and generates #probabilities" do
      { :get => "/games/probabilities" }.should route_to(:controller => "games", :action => "probabilities")
    end
          
    it "recognizes and generates #index" do
      { :get => "/games" }.should route_to(:controller => "games", :action => "index")
    end
    
    it "should not recognize #new" do
      { :get => "/games/new" }.should_not be_routable
    end
    
    it "should not recognize #edit" do
      { :get => "/games/1/edit" }.should_not be_routable
    end
    
    it "should not recognize #create" do
      { :post => "/games" }.should_not be_routable
    end
    
    it "should not recognize #update" do
      { :put => "/games/1" }.should_not be_routable
    end

    it "should not recognize #show" do
      { :get => "/games/1" }.should_not be_routable
    end

    it "should not recognize #destroy" do
      { :delete => "/games/1" }.should_not be_routable
    end
  end
end
