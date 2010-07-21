require 'spec_helper'

describe TwoPlayerMatrixGamesController do
  describe "routing" do
    
    it "recognizes and generates #statistics" do
      { :get => "/two_player_matrix_games/1/statistics" }.should route_to(:controller => "two_player_matrix_games", :action => "statistics", :id => "1")
    end
    
    it "should not recognize #index" do
      { :get => "/two_player_matrix_games" }.should_not be_routable
    end

    it "recognizes and generates #new" do
      { :get => "/two_player_matrix_games/new" }.should route_to(:controller => "two_player_matrix_games", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/two_player_matrix_games/1" }.should route_to(:controller => "two_player_matrix_games", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/two_player_matrix_games/1/edit" }.should route_to(:controller => "two_player_matrix_games", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/two_player_matrix_games" }.should route_to(:controller => "two_player_matrix_games", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/two_player_matrix_games/1" }.should route_to(:controller => "two_player_matrix_games", :action => "update", :id => "1") 
    end

    it "recognizes and generates #remove" do
      { :get => "/two_player_matrix_games/1/remove" }.should route_to(:controller => "two_player_matrix_games", :action => "remove", :id => "1") 
    end
    
    it "should not recognize #destroy" do
      { :delete => "/two_player_matrix_games/1" }.should_not be_routable
    end
  end
end
