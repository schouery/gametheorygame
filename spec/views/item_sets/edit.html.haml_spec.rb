require 'spec_helper'

describe "/item_sets/edit.html.haml" do
  include ItemSetsHelper

  before(:each) do
    assigns[:item_set] = @item_set = stub_model(ItemSet, :new_record? => false)
  end

  it "renders the edit item_set form" do
    render
    response.should have_tag("form[action=#{item_set_path(@item_set)}][method=post]") do
      with_tag('input#item_set_name[name=?]', "item_set[name]")
      ["hand_limit", "cards_per_hour"].each do |bonus_type|
        with_tag("input#item_set_bonus_type_#{bonus_type}[name=?][type=?][value=?]", "item_set[bonus_type]", "radio", bonus_type)      
      end
    end
  end
end
