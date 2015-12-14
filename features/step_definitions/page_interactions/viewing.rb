Then(/^I( don't)? see "([^"]*?)"$/) do |negate, content|
  if negate
    expect(page).to_not have_content(content)
  else
    expect(page).to have_content(content)
  end
end

Then(/^I( don't)? see the date "([^"]*?)"$/) do |negate, in_date_str|
  reformatted_date = Date.parse(in_date_str).formatted
  step "I#{negate} see \"#{reformatted_date}\""
end

Then(/^I see a message "([^"]*?)"$/) do |message|
  expect(page).to have_css(".alert", message)
end

Then(/^I see a success message "([^"]*?)"$/) do |message|
  expect(page).to have_css(".alert-success", message)
end

Then(/^I see an error message "([^"]*?)"$/) do |message|
  expect(page).to have_css(".alert-danger", message)
end

Then(/^I see a notice message "([^"]*?)"$/) do |message|
  expect(page).to have_css(".alert-notice", message)
end

Then(/^I see an info message "([^"]*?)"$/) do |message|
  expect(page).to have_css(".alert-info", message)
end
