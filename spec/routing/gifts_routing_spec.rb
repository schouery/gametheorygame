require 'spec_helper'

describe GiftsController do
  describe "routing" do

    it "recognizes and generates #send_money" do
      { :post => "/gifts/send_money" }.should route_to({:controller=>"gifts", :action=>"send_money"})
    end
    
    it "recognizes and generates #new_money" do
      { :get => "/gifts/new/money" }.should route_to( {:controller=>"gifts", :action=>"money"})
    end

    it "recognizes and generates #receive_money" do
      { :get => "/gifts/receive_money" }.should route_to(:controller => "gifts", :action => "receive_money") 
    end

    it "recognizes and generates #index" do
      { :get => "/gifts" }.should route_to(:controller => "gifts", :action => "index")
    end
    
    it "recognizes and generates #new" do
      { :get => "/gifts/new" }.should_not be_routable
    end
    
    it "recognizes and generates #edit" do
      { :get => "/gifts/1/edit" }.should_not be_routable
    end
    
    it "recognizes and generates #create" do
      { :post => "/gifts" }.should_not be_routable
    end
    
    it "recognizes and generates #update" do
      { :put => "/gifts/1" }.should_not be_routable
    end

    it "recognizes and generates #show" do
      { :get => "/gifts/1" }.should_not be_routable
    end

    it "recognizes and generates #destroy" do
      { :delete => "/gifts/1" }.should_not be_routable
    end
  end
end
