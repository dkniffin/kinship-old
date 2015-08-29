When(/^I visit the admin (settings|dashboard) (?:path|url|page)$/) do |page|
  visit "/admin/#{page}"
end
Then(/^I am on the admin dashboard page$/) do
  expect(page.current_path).to eq('/admin/dashboard')
end
