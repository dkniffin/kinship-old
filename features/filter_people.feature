Feature: Filter people searches by gender

 As a user
 So that I can more easily find people in the index
 I want to be able to filter search results by gender

Background: people have been added to the database

  Given the following people exist:
   | first_name | last_name | gender |
   | Derek      | Kniffin   | M      |
   | Greg       | Wahl      | M      |
   | Joe        | Smith     | M      |
   | Sally      | Banana    | F      |

  And I am on the People index page

Scenario: filter out females
 Given I check the following genders: M
 And I uncheck the following genders: F
 And I press "Search"
 Then I should see people with the following genders: M
 And I should not see people with the following genders: F

Scenario: filter out males
 Given I check the following genders: F
 And I uncheck the following genders: M
 And I press "Search"
 Then I should see people with the following genders: F
 And I should not see people with the following genders: M

 Scenario: don't filter
 Given I check the following genders: F
 And I check the following genders: M
 And I press "Search"
 Then I should see all people

