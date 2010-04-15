require 'spec_helper'

describe "/trashes/edit.html.erb" do
  include TrashesHelper

  before(:each) do
    assigns[:trash] = @trash = stub_model(Trash,
      :new_record? => false,
      :name => "value for name"
    )
  end

  it "renders the edit trash form" do
    render

    response.should have_tag("form[action=#{trash_path(@trash)}][method=post]") do
      with_tag('input#trash_name[name=?]', "trash[name]")
    end
  end
end
