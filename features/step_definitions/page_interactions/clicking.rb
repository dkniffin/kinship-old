When(/^I click "([^"]*?)"$/) do |target|
  case target
  when /^submit$/i
    find('[type="submit"]').click
  when /(Edit|Delete)" for the person "(.*)/
    find(:xpath, "//tr[contains(.,'#{$2}')]/td/div/a", :text => $1).click
  else
    click_on(target)
  end
end

When(/^I confirm the prompt$/) do
  page.evaluate_script('window.confirm = function() { return true; }')
end
