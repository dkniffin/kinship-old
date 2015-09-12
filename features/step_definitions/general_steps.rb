When(/^I visit the(?: site)? root (?:path|url|page)$/) do
  visit '/'
end
When(/^I (?:visit|goto|go to) the login (?:path|page)$/) do
  visit new_user_session_path
end
Then(/^I am on the home page$/) do
  expect(page.current_path).to eq('/')
end


When(/^I click "(.*?)"$/) do |target|
  case target
  when /^submit$/i
    find('[type="submit"]').click
  when /(Edit|Delete)" for the person "(.*)/
    find(:xpath, "//tr[contains(.,'#{$2}')]/td/div/a", :text => $1).click
  else
    click_on(target)
  end
end
When(/^I click the "(.*?)" button$/) do |btn_text|
  find('[type="submit"]', btn_text).click
end
When(/^I (?:enter|fill in) "(.*?)" for "(.*?)"$/) do |value, field|
  fill_in(field, with: value)
end

Then(/^I am redirected to the home page$/) do
  expect(current_path).to eq(root_path)
end


Then(/^I( don't)? see "(.*?)"$/) do |negate, content|
  if negate
    expect(page).to_not have_content(content)
  else
    expect(page).to have_content(content)
  end
end
Then(/^I( don't)? see the date "(.*?)"$/) do |negate, in_date_str|
  reformatted_date = Date.parse(in_date_str).formatted
  step "I#{negate} see \"#{reformatted_date}\""
end

Then(/^I see an error "(.*?)"$/) do |error_message|
  expect(page).to have_css(".alert", error_message)
end

When(/^I confirm the prompt$/) do
  page.driver.browser.accept_js_confirms
end
