require 'spec_helper'

describe "/item_types/index.html.haml" do
  include ItemTypesHelper

  before(:each) do
    assigns[:item_types] = [
      stub_model(ItemType,
        :name => "value for name"
      ),
      stub_model(ItemType,
        :name => "value for name"
      )
    ]
    assigns[:item_set] = stub_model(ItemSet, :name => "Item Set")
  end

  it "renders a list of item_types" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
