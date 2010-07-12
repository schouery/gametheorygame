require 'spec_helper'

describe "/configurations/edit.html.haml" do
  include ConfigurationsHelper
  
  before(:each) do
    assigns[:configuration] = @configuration = Configuration.instance    
  end

  it "renders the edit configuration form" do
    render
    response.should have_tag("form[action=#{configuration_path(@configuration)}][method=post]") do
      with_tag('input#configuration_money_gift_value[name=?]', "configuration[money_gift_value]")
      with_tag('input#configuration_full_permissions_to_researchers_true[name=?][type=?][value=?]', "configuration[full_permissions_to_researchers]", "radio", "true")
      with_tag('input#configuration_full_permissions_to_researchers_false[name=?][type=?][value=?]', "configuration[full_permissions_to_researchers]", "radio", "false")
      with_tag('input#configuration_researcher_can_invite_researcher_true[name=?][type=?][value=?]', "configuration[researcher_can_invite_researcher]", "radio", "true")
      with_tag('input#configuration_researcher_can_invite_researcher_false[name=?][type=?][value=?]', "configuration[researcher_can_invite_researcher]", "radio", "false")
      with_tag('input#configuration_card_gift_limit[name=?]', "configuration[card_gift_limit]")
      with_tag('input#configuration_money_gift_limit[name=?]', "configuration[money_gift_limit]")
      with_tag('input#configuration_starting_money[name=?]', "configuration[starting_money]")
      with_tag('input#configuration_starting_cards[name=?]', "configuration[starting_cards]")
      with_tag('input#configuration_item_probability[name=?]', "configuration[item_probability]")
      with_tag('input#configuration_starting_cards_per_hour[name=?]', "configuration[starting_cards_per_hour]")
      with_tag('input#configuration_starting_hand_limit[name=?]', "configuration[starting_hand_limit]")
    end
  end
end
