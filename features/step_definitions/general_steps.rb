When(/^I visit the(?: site)? root (?:path|url|page)$/) do
  visit '/'
end

When(/^I (?:visit|goto|go to) the login (?:path|page)$/) do
  visit new_user_session_path
end

When(/^I visit "([^"]*?)"$/) do |path|
  visit path
end

Then(/^I am on the home page$/) do
  expect(page.current_path).to eq('/')
end


When(/^I click "([^"]*?)"$/) do |target|
  case target
  when /^submit$/i
    find('[type="submit"]').click
  when /(Edit|Delete)" for the person "(.*)/
    find(:xpath, "//tr[contains(.,'#{$2}')]/td/div/a", :text => $1).click
  else
    click_on(target)
  end
end

When(/^I click the "([^"]*?)" button$/) do |btn_text|
  find('[type="submit"]', btn_text).click
end

When(/^I (?:enter|fill in) "(.*?)" for "(.*?)"$/) do |value, field|
  fill_in(field, with: value)
end

When(/^I select "([^"]*)" for "(.*?)"$/) do |value, field|
  select(value, from: field)
end

# Source: https://gist.github.com/lbspen/5674563
def select_date(date, options = {})
  date = Date.parse(date) if date.class == String
  field = options[:from]
  base_id = find(:xpath, ".//label[contains(.,'#{field}')]")[:for]

  year_format = options[:year_format] || '%Y'
  year = date.strftime(year_format)

  month_format = options[:month_format] || '%B'
  month = date.strftime(month_format)

  day_format = options[:day_format] || '%-d'
  day = date.strftime(day_format)

  select year,  :from => "#{base_id}_1i"
  select month, :from => "#{base_id}_2i"
  select day,   :from => "#{base_id}_3i"
end

When(/^I select the date "([^"]*)" for "(.*?)"$/) do |in_date_str, field|
  select_date(in_date_str, from: field)
end

Then(/^I am redirected to the home page$/) do
  expect(current_path).to eq(root_path)
end


Then(/^I( don't)? see "([^"]*?)"$/) do |negate, content|
  if negate
    expect(page).to_not have_content(content)
  else
    expect(page).to have_content(content)
  end
end

Then(/^"([^"]*?)" is filled in with "([^"]*?)"$/) do |field, value|
  expect(page).to have_select(field, selected: value)
end

Then(/^I( don't)? see the date "([^"]*?)"$/) do |negate, in_date_str|
  reformatted_date = Date.parse(in_date_str).formatted
  step "I#{negate} see \"#{reformatted_date}\""
end

Then(/^I see an error "([^"]*?)"$/) do |error_message|
  expect(page).to have_css(".alert", error_message)
end

When(/^I confirm the prompt$/) do
  page.driver.browser.accept_js_confirms
end
