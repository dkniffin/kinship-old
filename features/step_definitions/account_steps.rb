Given(/^I do not have an account on the site$/) do
  User.delete_all
  @account_details = { :email => 'new_account@nowhere.com', :password => '123!newpw' }
end
Given(/^I have an? (unapproved|member|editor|admin) account(?: on the site)?$/) do |role|
  @account_details = {
    :email    => 'testing@nowhere.com',
    :password => 'test123!',
    :role     => User.role_from_string(role)
  }
  @account = User.create(@account_details)
end
Given(/^my account has been approved?$/) do
  @account.update(role: User::ROLE_MEMBER)
end
Given(/^I log in$/) do
  step 'I visit the login page'
  step 'I enter my email'
  step 'I enter my password'
  step 'I click "submit"'
end
Given(/^I am logged in as an? (member|editor|admin)$/) do |role|
  step "I have a #{role} account"
  step 'I log in'
end


When(/^I enter my email(?:| address)$/) do
  step "I enter \"#{@account_details[:email]}\" as my email address"
end
When(/^I enter "(.*?)" as my email address$/) do |value|
  fill_in('Email', :with => value)
end

When(/^I enter (?:my|the)( wrong| incorrect)? password$/) do |incorrect|
  pw = incorrect ? 'b0gUs' : @account_details[:password]
  step "I enter \"#{pw}\" as my password"
end
When(/^I enter "(.*?)" as my password$/) do |pw|
  fill_in('Password', :with => pw)
end

When(/^I enter a password with (in)?correct(?: password)? confirmation$/) do |incorrect|
  pw = incorrect ? "!thesame" : @account_details[:password]
  fill_in('Password', :with => @account_details[:password])
  fill_in('Password confirmation', :with => pw)
end



Then(/^my account is unapproved$/) do
    User.where(email: @account_details[:email]).present?
end

Then(/^I am presented with a login page$/) do
  expect(page).to have_content('Log in')
  expect(page).to have_xpath("//input[@type='email']")
  expect(page).to have_xpath("//input[@type='password']")
end

Then(/^I am notified that my password confirmation does not match$/) do
  expect(page).to have_content("Password confirmation doesn't match Password")
end

Then(/^I am notified that my password is incorrect$/) do
  expect(page).to have_content("Invalid email or password.")
end

Then(/^I am notified that my email address is invalid\.$/) do
  expect(page).to have_content('Email is invalid')
end
