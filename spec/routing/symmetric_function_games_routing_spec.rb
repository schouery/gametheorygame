require 'spec_helper'

describe SymmetricFunctionGamesController do
  describe "routing" do
    
    it "recognizes and generates #statistics" do
      { :get => "/symmetric_function_games/1/statistics" }.should route_to(:controller => "symmetric_function_games", :action => "statistics", :id => "1")
    end
    
    it "recognizes and generates #index" do
      { :get => "/symmetric_function_games" }.should_not be_routable
      # { :get => "/symmetric_function_games" }.should route_to(:controller => "symmetric_function_games", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/symmetric_function_games/new" }.should route_to(:controller => "symmetric_function_games", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/symmetric_function_games/1" }.should route_to(:controller => "symmetric_function_games", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/symmetric_function_games/1/edit" }.should route_to(:controller => "symmetric_function_games", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/symmetric_function_games" }.should route_to(:controller => "symmetric_function_games", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/symmetric_function_games/1" }.should route_to(:controller => "symmetric_function_games", :action => "update", :id => "1") 
    end

    it "recognizes and generates #remove" do
      { :get => "/symmetric_function_games/1/remove" }.should route_to(:controller => "symmetric_function_games", :action => "remove", :id => "1") 
    end
  end
end
