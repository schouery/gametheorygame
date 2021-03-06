require 'spec_helper'

describe GiftsController do
  describe "routing" do
    it "recognizes and generates #send_card" do
      { :post => "/gifts/1/send_card" }.should route_to({:controller=>"gifts", :action=>"send_card", :id => '1'})
    end
  
    it "recognizes and generates #card" do
      { :get => "/gifts/1/card" }.should route_to( {:controller=>"gifts", :action=>"card", :id => '1'})
    end

    it "recognizes and generates #receive_card" do
      { :get => "/gifts/1/receive_card" }.should route_to(:controller => "gifts", :action => "receive_card", :id => '1') 
    end

    it "recognizes and generates #send_item" do
      { :post => "/gifts/1/send_item" }.should route_to({:controller=>"gifts", :action=>"send_item", :id => '1'})
    end
  
    it "recognizes and generates #item" do
      { :get => "/gifts/1/item" }.should route_to( {:controller=>"gifts", :action=>"item", :id => '1'})
    end

    it "recognizes and generates #receive_item" do
      { :get => "/gifts/1/receive_item" }.should route_to(:controller => "gifts", :action => "receive_item", :id => '1') 
    end

    it "recognizes and generates #send_money" do
      { :post => "/gifts/send_money" }.should route_to({:controller=>"gifts", :action=>"send_money"})
    end
    
    it "recognizes and generates #money" do
      { :get => "/gifts/money" }.should route_to( {:controller=>"gifts", :action=>"money"})
    end

    it "recognizes and generates #receive_money" do
      { :get => "/gifts/receive_money" }.should route_to(:controller => "gifts", :action => "receive_money") 
    end

    it "recognizes and generates #index" do
      { :get => "/gifts" }.should route_to(:controller => "gifts", :action => "index")
    end
    
    it "should not recognize #new" do
      { :get => "/gifts/new" }.should_not be_routable
    end
    
    it "should not recognize #edit" do
      { :get => "/gifts/1/edit" }.should_not be_routable
    end
    
    it "should not recognize #create" do
      { :post => "/gifts" }.should_not be_routable
    end
    
    it "should not recognize #update" do
      { :put => "/gifts/1" }.should_not be_routable
    end

    it "should not recognize #show" do
      { :get => "/gifts/1" }.should_not be_routable
    end

    it "should not recognize #destroy" do
      { :delete => "/gifts/1" }.should_not be_routable
    end
  end
end
