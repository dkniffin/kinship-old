# Index
When(/^I visit the (\S+) index page$/) do |object|
  visit "/#{ModelHelper.to_resource(object)}"
end

Then(/^I am on the (\S+) index page$/) do |object|
  expect(current_path).to eq("/#{ModelHelper.to_resource(object)}")
end

# New
When(/^I visit the new (\S+) page$/) do |object|
  visit "/#{ModelHelper.to_resource(object)}/new"
end

Then(/^I am on the new (\S+) page$/) do |object|
  expect(current_path).to eq("/#{ModelHelper.to_resource(object)}/new")
end

# Show
Then(/^I am on the (\S+) show page$/) do |object|
  expect(current_path).to match(%r{/#{ModelHelper.to_resource(object)}/\d+})
end

# Edit
Then(/^I am on the (\S+) edit page$/) do |object|
  expect(current_path).to match(%r{/#{ModelHelper.to_resource(object)}/\d+/edit})
end
