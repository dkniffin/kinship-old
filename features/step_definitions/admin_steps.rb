Given(/^there is an unapproved user$/) do
  @unapproved_user = User.create({
    email:    'unapproved@nowhere.com',
    password: 'bogus123',
    role:     User::ROLE_UNAPPROVED})
end
When(/^I visit the admin (settings|dashboard|users) (?:path|url|page)$/) do |admin_page|
  visit "/admin/#{admin_page}"
end
Then(/^I am on the admin (settings|dashboard|users) page$/) do |admin_page|
  expect(page.current_path).to eq("/admin/#{admin_page}")
end
Then(/^I am on the admin edit page for the unapproved user$/) do
  expect(page.current_path).to eq("/admin/users/#{@unapproved_user.id}/edit")
end

Then(/^I see the unapproved user's email address$/) do
  step "I see \"#{@unapproved_user.email}\""
end
Then(/^I see the unapproved user is unapproved$/) do
  expect(page).to have_css("#user_role", 'unapproved')
end

When(/^I click on the unapproved user's email$/) do
  step "I click \"#{@unapproved_user.email}\""
end
Then(/^the user's role is "(.*?)"$/) do |arg1|
  expect(@unapproved_user.reload.role).to eq(User::ROLE_MEMBER)
end

Then(/^the (map_tile_url|map_lat_lng|map_zoom) setting is "(.*?)"$/) do |setting, value|
  expect(Setting.send(setting).to_s).to eq(value)
end
