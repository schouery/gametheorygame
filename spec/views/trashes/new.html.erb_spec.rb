require 'spec_helper'

describe "/trashes/new.html.erb" do
  include TrashesHelper

  before(:each) do
    assigns[:trash] = stub_model(Trash,
      :new_record? => true,
      :name => "value for name"
    )
  end

  it "renders new trash form" do
    render

    response.should have_tag("form[action=?][method=post]", trashes_path) do
      with_tag("input#trash_name[name=?]", "trash[name]")
    end
  end
end
