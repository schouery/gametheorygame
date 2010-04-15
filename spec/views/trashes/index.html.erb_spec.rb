require 'spec_helper'

describe "/trashes/index.html.erb" do
  include TrashesHelper

  before(:each) do
    assigns[:trashes] = [
      stub_model(Trash,
        :name => "value for name"
      ),
      stub_model(Trash,
        :name => "value for name"
      )
    ]
  end

  it "renders a list of trashes" do
    render
    response.should have_tag("tr>td", "value for name".to_s, 2)
  end
end
