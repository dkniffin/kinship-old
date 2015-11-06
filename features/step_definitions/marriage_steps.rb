Then(/^I am on the new marriage page$/) do
  expect(current_path).to match(/\life_event\/marriages\/new/)
end

Then(/^I am on the marriage show page$/) do
  expect(current_path).to match(/\life_event\/marriages\/\d+/)
end
