require 'spec_helper'

describe "/item_sets/index.html.haml" do

  before(:each) do
    assigns[:item_sets] = [
      stub_model(ItemSet,
        :name => "Item Set 1",
        :bonus_type => "hand_limit"
      ),
      stub_model(ItemSet,
        :name => "Item Set 2",
        :bonus_type => "cards_per_hour"
      )
    ]
    @controller.stub(:can? => true)
  end

  it "renders a list of item_sets" do
    render
    response.should contain("Item Set 1")
    response.should contain("Hand limit")
    response.should contain("Item Set 2")
    response.should contain("Cards per hour")
  end
end
