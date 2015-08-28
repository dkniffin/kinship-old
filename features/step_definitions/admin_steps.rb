When(/^I visit the admin (settings) (?:path|url|page)$/) do |page|
  visit "/admin/#{page}"
end
