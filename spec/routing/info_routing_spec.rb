require 'spec_helper'

describe InfoController do
  describe "routing" do    
    it "recognizes and generates #manual" do
      { :get => "/manual"}.should route_to(:controller => "info", :action => "manual")
    end
    it "recognizes and generates #admin_manual" do
      { :get => "/admin_manual"}.should route_to(:controller => "info", :action => "admin_manual")
    end
    it "recognizes and generates #manual" do
      { :get => "/researcher_manual"}.should route_to(:controller => "info", :action => "researcher_manual")
    end
  end
end