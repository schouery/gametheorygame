Given /^I am player$/ do
  @current_user = Factory(:user)
end

Given /^I have some cards$/ do
  @current_user.cards = [Factory(:card)]
end