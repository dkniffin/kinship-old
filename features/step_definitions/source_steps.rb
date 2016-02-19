When(/^I fill in valid source data$/) do
  fill_in("Title", with: "2230 Census")
end

Then(/^I see a table of sources$/) do
  expect(page).to have_css('table#sources')
end

Then(/^the table of sources is sorted by "(.*?)"$/) do |attribute|
  method_sym = attribute.downcase.to_sym
  first = Source.find(1).send(method_sym)
  second = Source.find(2).send(method_sym)
  expect(page).to have_content(/#{first}.*#{second}/m)
end

Then(/^the table is paginated$/) do
  expect(page).to have_css('.pagination')
end

When(/^I visit the show page for the first source$/) do
  visit "/sources/#{Source.first.id}"
end
