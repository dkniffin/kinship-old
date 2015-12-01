def resourcify(object)
  object.downcase.pluralize
end

When(/^I visit the (\S+) index page$/) do |object|
  visit "/#{resourcify(object)}"
end

When(/^I visit the new (\S+) page$/) do |object|
  visit "/#{resourcify(object)}/new"
end
