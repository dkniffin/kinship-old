Feature: Search for people by first and last name

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

Scenario: search by first name
 Given I enter "Sally" in the search box
 And I check the following genders: F, M
 And I press "Search"
 Then I should see the following people: Sally
 And I should not see the following people: Derek, Greg, Joe

Scenario: search by last name
 Given I enter "Wahl" in the search box
 And I check the following genders: F, M
 And I press "Search"
 Then I should see the following people: Greg
 And I should not see the following people: Derek, Sally, Joe

 Scenario: don't search
 Given I enter "" in the search box
 And I check the following genders: F, M
 And I press "Search"
 Then I should see all people
