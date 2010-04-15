require 'spec_helper'

describe "/trashes/show.html.erb" do
  include TrashesHelper
  before(:each) do
    assigns[:trash] = @trash = stub_model(Trash,
      :name => "value for name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ name/)
  end
end
