require 'spec_helper'

describe InfoController do
  describe "routing" do    
    it "recognizes and generates #manual" do
      { :get => "/manual"}.should route_to(:controller => "info", :action => "manual")
    end
  end
end
