When(/^I click "(.*?)" for the event "(.*?)"$/) do |target, event|
  within find('tr', text: event) do
    click_on(target)
  end
end
