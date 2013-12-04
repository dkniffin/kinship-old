require 'uri'
require 'cgi'

module WithinHelpers
  def with_scope(locator)
    locator ? within(*selector_for(locator)) { yield } : yield
  end
end
World(WithinHelpers)

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

###### BEGIN CUSTOM STEPS ##########################
Given /the following people exist/ do |people_table|
  people_table.hashes.each do |person|
    if !Person.find_by_first_name_and_last_name(person[:first_name], person[:last_name]) then
       Person.create!(person)
    end
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  page.body.should =~ /(\s|\S)+#{e1}(\s|\S)+#{e2}/
end

Then /I should see people with the following genders: (.*)/ do |gender_list|
  @gender_list = gender_list.gsub(/\s+/,"").split(",")
  @filtered_people = Person.where(:gender => @gender_list)
  @filtered_people.each do | person |
     text = person.first_name
     if page.respond_to? :should
        page.should have_content(text)
     else
        assert page.has_content?(text)
     end
     text = person.last_name
     if page.respond_to? :should
        page.should have_content(text)
     else
        assert page.has_content?(text)
     end
  end
end

Then /I should not see people with the following genders: (.*)/i do |gender_list|
  @gender_list = gender_list.gsub(/\s+/,"").split(",")
  @rated_people = Person.where(:gender => @gender_list)
  @rated_people.each do | person |
     text = person.first_name
     if page.respond_to? :should
        page.should have_no_content(text)
     else
        assert page.has_no_content?(text)
     end
     text = person.last_name
     if page.respond_to? :should
        page.should have_no_content(text)
     else
        assert page.has_no_content?(text)
     end
  end
end

When /I (un)?check the following genders: (.*)/ do |uncheck, gender_list|
  @gender_list = gender_list.gsub(/\s+/,"").split(",")
  @gender_list.each do | gender |
     if uncheck
        uncheck("genders_#{gender}")
     else
        check("genders_#{gender}")
     end
  end
end

# Code for checking that all genders gives all people
Given /^I check all genders$/ do
  @genders = Person.select("DISTINCT gender").map(&:gender).sort
  @genders.each do |gender|
     check("genders_#{gender}")
  end
end

Then /^I should see all people$/ do
  @num_people = Person.all.length
  @num_rows = all("tbody tr").length 
  @num_rows.should == @num_people
end
################### End Custom Steps ################################

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end
