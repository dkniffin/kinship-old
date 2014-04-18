Feature: sort the index of people by first and last name

 As a user
 So that I can more easily find people in the index
 I want to be able to sort by first and last name

Background: people have been added to the database

  Given the following people exist:
   | first_name | last_name | gender |
   | Derek      | Kniffin   | M      |
   | Greg       | Wahl      | M      |
   | Joe        | Smith     | M      |

  And I am on the People index page

Scenario: sort people by first name
 Given I follow "First Name"
 Then I should see "Greg" before "Joe"

Scenario: sort people by last name
 Given I follow "Last Name"
 Then I should see "Smith" before "Wahl"
