Given(/^the database is seeded with (\d+) (.*)$/) do |n, object|
  create_list(object.singularize.to_sym, n.to_i)
end

Then(/^there is (?:a|1) (.*) in the database$/) do |object|
  step "there are 1 #{object} in the database"
end

Then(/^there are (\d+) (.*) in the database$/) do |n, object|
  count = ModelHelper.to_class(object.singularize).count
  expect(count).to eq(n.to_i)
end
