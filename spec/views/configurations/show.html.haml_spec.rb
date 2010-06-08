require 'spec_helper'

describe "/configurations/show.html.haml" do
  include ConfigurationsHelper
  before(:each) do
    assigns[:configuration] = @configuration = Configuration.instance
  end

  it "renders attributes in <p>" do
    render
    response.should contain(@configuration.money_gift_value.to_s)
  end
end
