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

  select year,  from: "#{base_id}_1i"
  select month, from: "#{base_id}_2i"
  select day,   from: "#{base_id}_3i"
end

When(/^I select the date "([^"]*)" for "(.*?)"$/) do |in_date_str, field|
  select_date(in_date_str, from: field)
end

Then(/^"([^"]*?)" is filled in with "([^"]*?)"$/) do |field, value|
  expect(page).to have_select(field, selected: value)
end
