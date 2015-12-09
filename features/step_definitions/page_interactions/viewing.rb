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

Then(/^I see an (?:error|alert) "([^"]*?)"$/) do |error_message|
  expect(page).to have_css(".alert", error_message)
end

Then(/^I see a (?:notification|notice) "([^"]*?)"$/) do |notice_message|
  expect(page).to have_css(".notice", notice_message)
end
