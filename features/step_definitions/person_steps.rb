Given(/^there is a person with the name "(.*?)"$/) do |name|
  first,last = name.split(' ')
  @person = create(:person, first_name: first, last_name: last)
end

When(/^I enter the following details for (?:a new person|new people):$/) do |table|
  # table is a Cucumber::Ast::Table
  table.hashes.each do |hash|
    fill_in("First name", with: hash[:first_name])
    fill_in("Last name", with: hash[:last_name])
    select(hash[:gender], from: "Gender")
  end
end

When(/^I visit the person show page for "(.*?)"$/) do |name|
  first_name, last_name = name.split(' ')
  person = Person.where(first_name: first_name, last_name: last_name).first
  visit "/people/#{person.id}"
end

When(/^I visit the (edit|show) page for the person "([^"]*)"$/) do |page, name|

  person = Person.find_by(first_name: first, last_name: last)
  edit_url_segment = (page == 'edit') ? '/edit' : ''
  visit "/people/#{person.id}#{edit_url_segment}"
end

When(/^I visit the show page for the first person$/) do
  visit "/people/#{Person.first.id}"
end

When(/^I fill in valid person data$/) do
  # TODO: Generalize this
  person_attributes = attributes_for(:person)
  # Name
  fill_in("First name", with: person_attributes[:first_name])
  fill_in("Last name", with: person_attributes[:last_name])
  # Gender
  select(person_attributes[:gender], from: "Gender")
end

Then(/^I am on the person show page for "(.*?)"$/) do |name|
  person = Person.where(name: name)
  expect(page.current_path).to eq("/people/#{person.id}")
end

Then(/^the table has the person "(.*)"$/) do |name|
  first, last = name.split(' ')
  expect(page).to have_css('tr', text: /#{first}.*#{last}/)
end
