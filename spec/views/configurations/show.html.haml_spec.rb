require 'spec_helper'

describe "/configurations/show.html.haml" do
  include ConfigurationsHelper
  before(:each) do
    assigns[:configuration] = @configuration = Configuration.instance
  end

  it "renders attributes in <p>" do
    render
    response.should contain(@configuration.money_gift_value.to_s)
    response.should contain(@configuration.full_permissions_to_researchers.to_s)
    response.should contain(@configuration.researcher_can_invite_researcher.to_s)
    response.should contain(@configuration.card_gift_limit.to_s)
    response.should contain(@configuration.money_gift_limit.to_s)
    response.should contain(@configuration.hand_limit.to_s)
    response.should contain(@configuration.starting_money.to_s)
  end
end
