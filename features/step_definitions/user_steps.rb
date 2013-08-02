
require 'fabrication'

Given(/^I have signed up as "(.*?)"$/) do |email|
  visit(signup_path)
  # step %{show me the page}
  fill_in('user_email', :with => email)
  fill_in('user_password', :with => 'changeme')
  fill_in('user_password_confirmation', :with => 'changeme')
  click_button('Create User')
end

Given /^I am logged in as "([^\"]*)"$/ do |user_email|
  user = User.find_by_email(user_email) || Fabricate(:user, :email => user_email)
  visit(login_path)
  fill_in('user_email', with: user_email)
  fill_in('user_password', with: 'changeme')
  click_button('Log in')
end

