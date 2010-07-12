require 'spec_helper'

describe "/item_sets/new.html.haml" do
  include ItemSetsHelper

  before(:each) do
    assigns[:item_set] = stub_model(ItemSet,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new item_set form" do
    render

    response.should have_tag("form[action=?][method=post]", item_sets_path) do
      with_tag("input#item_set_name[name=?]", "item_set[name]")
      ["hand_limit", "cards_per_hour"].each do |bonus_type|
        with_tag("input#item_set_bonus_type_#{bonus_type}[name=?][type=?][value=?]", "item_set[bonus_type]", "radio", bonus_type)      
      end
    end
  end
end
