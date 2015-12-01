Feature: Change user settings through the admin panel
  Scenario: Approve users/change roles
    Given I am logged in as an admin
    And there is an unapproved user
    When I visit the admin users page
    Then I see the unapproved user's email address
    When I click on the unapproved user's email
    Then I am on the admin edit page for the unapproved user
    And I see the unapproved user is unapproved
    When I fill in "member" for "Role"
    And I click "Update User"
    Then the user's role is "member"
