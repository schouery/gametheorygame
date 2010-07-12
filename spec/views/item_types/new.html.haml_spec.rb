require 'spec_helper'

describe "/item_types/new.html.haml" do
  include ItemTypesHelper

  before(:each) do
    assigns[:item_type] = stub_model(ItemType,
      :new_record? => true,
      :name => "value for name",
      :item_set_id => 1
    )
    @item_set = assigns[:item_set] = stub_model(ItemSet, :name => "Item Set")
  end

  it "renders new item_type form" do
    render
    response.should have_tag("form[action=?][method=post]", item_set_item_types_path(@item_set)) do
      with_tag("input#item_type_name[name=?]", "item_type[name]")
    end
  end
end
