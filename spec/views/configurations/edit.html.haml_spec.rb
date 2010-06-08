require 'spec_helper'

class Configuration < ActiveRecord::Base
  def acts_as_singleton
  end
end

describe "/configurations/edit.html.haml" do
  include ConfigurationsHelper
  
  before(:each) do
    assigns[:configuration] = @configuration = Configuration.instance
  end

  it "renders the edit configuration form" do
    render

    response.should have_tag("form[action=#{configuration_path(@configuration)}][method=post]") do
      with_tag('input#configuration_money_gift_value[name=?]', "configuration[money_gift_value]")
    end
  end
end
