# User-defined
When(/^I visit "([^"]*?)"$/) do |path|
  visit path
end

Then(/^I am on "([^"]*)"$/) do |path|
  expect(current_path).to eq path
end

# Home
When(/^I visit the(?: site)? (?:root|home) (?:path|url|page)$/) do
  step "I visit \"/\""
end

Then(/^I am (?:on|redirected to) the(?: site)? (?:root|home) (?:path|url|page)$/) do
  step "I am on \"/\""
end

# Log in
When(/^I (?:visit|goto|go to) the login (?:path|page)$/) do
  step "I visit \"#{new_user_session_path}\""
end

When(/^I am (?:on|redirected to) the login (?:path|page)$/) do
  step "I am on \"#{new_user_session_path}\""
end
