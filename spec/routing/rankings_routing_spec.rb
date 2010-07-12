require 'spec_helper'

describe RankingsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/rankings" }.should route_to(:controller => "rankings", :action => "index")
    end

    it "recognizes and generates #edit" do
      { :get => "/rankings/1/edit" }.should_not be_routable
    end

    it "recognizes and generates #create" do
      { :post => "/rankings" }.should_not be_routable
    end

    it "recognizes and generates #update" do
      { :put => "/rankings/1" }.should_not be_routable
    end

    it "recognizes and generates #show" do
      { :get => "/rankings/1" }.should route_to(:controller => "rankings", :action => "show", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/rankings/1" }.should_not be_routable
    end

  end
end