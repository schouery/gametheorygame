require 'spec_helper'

describe "/item_types/show.html.haml" do
  include ItemTypesHelper
  before(:each) do
    assigns[:item_type] = @item_type = stub_model(ItemType,
      :name => "Item Type"
    )
    assigns[:item_set] = stub_model(ItemSet, :name => "Item Set")
    @controller.stub(:can? => true)
  end

  it "renders attributes in <p>" do
    render
    response.should contain("Item Type")
    response.should contain("Item Set")
  end
end
