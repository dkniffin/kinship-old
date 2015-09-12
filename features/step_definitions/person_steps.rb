Given(/^there (?:is|are) (\d+) (?:person|people) in the database$/) do |num|
  num = num.to_i
  create_list(:person, num)
  @person = Person.first if num == 1
end
Given(/^there is a person with name "(.*?)"$/) do |name|
  first,last = name.split(' ')
  @person = create(:person, first_name: first, last_name: last)
end

When(/^I visit the person index page$/) do
  visit '/people'
end
When(/^I visit the new person page$/) do
  visit '/people/new'
end
When(/^I visit the show page for that person$/) do
  visit "/people/#{@person.id}"
end
When(/^I visit the edit page for that person$/) do
  visit "/people/#{@person.id}/edit"
end

When(/^I fill in valid person data$/) do
  @person_attributes = attributes_for(:person)
  # Name
  fill_in("First name", with: @person_attributes[:first_name])
  fill_in("Last name", with: @person_attributes[:last_name])
  # Gender
  select(@person_attributes[:gender], from: "Gender")
  # Birth date
  select(@person_attributes[:birth_date], from: "Birth Date")
end



Then(/^I am on the person show page$/) do
  expect(page.current_path).to match(/\/people\/(\d+)/)
end
Then(/^I am on the person index page$/) do
  expect(page.current_path).to eq("/people")
end

Then(/^I see the person$/) do
  full_name = @person.try(:full_name) || @person_attributes[:full_name]
  step "I see \"#{full_name}\""
end

Then(/^the person should be created$/) do
  ppl = Person.where(@person_attributes)
  expect(ppl.count).to be >= 1
  @person = ppl.first
end

Then(/^the person's first name should be "(.*?)"$/) do |first_name|
  expect(@person.reload.first_name).to eq(first_name)
end

Then(/^the person no longer exists$/) do
  expect(Person.exists?(Person)).to eq(false)
end
