require 'spec_helper'

describe ConfigurationsController do
  describe "routing" do
    it "recognizes and generates #new" do
      { :get => "/configuration/new" }.should_not be_routable
    end

    it "recognizes and generates #show" do
      { :get => "/configuration" }.should route_to(:controller => "configurations", :action => "show")
    end

    it "recognizes and generates #edit" do
      { :get => "/configuration/edit" }.should route_to(:controller => "configurations", :action => "edit")
    end

    it "recognizes and generates #create" do
      { :post => "/configuration" }.should_not be_routable
    end

    it "recognizes and generates #update" do
      { :put => "/configuration" }.should route_to(:controller => "configurations", :action => "update") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/configuration/1" }.should_not be_routable
    end
  end
end
