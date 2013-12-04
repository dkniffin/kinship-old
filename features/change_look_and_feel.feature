Feature: Change the website look and feel

 As a user
 So that I can more easily find people in the index
 I want to be able to sort by first and last name

Background: At the look and feel page

  Given I log in as "admin" with password "kinship"
  And I am on the Admin Look & Feel Page

Scenario: change the homepage blurb
 Given I enter "<p>Hello World</p>" for the Homepage Blurb
 And I press "Save"
 And I follow "Home"
 Then I should see "Hello World"

Scenario: change the Site Header
 Given I enter "My super awesome genealogy site" for the Site Header
 And I press "Save"
 And I follow "Home"
 Then I should see "My super awesome genealogy site"
