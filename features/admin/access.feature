Feature: Access to the admin panel is only allowed to admins
  Scenario: An admin has access to the admin panel
    Given I am logged in as an admin
    When I visit the admin dashboard page
    Then I am on the admin dashboard page

  Scenario: A member does not have access to the admin panel
    Given I am logged in as a member
    When I visit the admin dashboard page
    Then I am on the home page
    And I see "You are not authorized to perform this action"

  Scenario: An editor does not have access to the admin panel
    Given I am logged in as an editor
    When I visit the admin dashboard page
    Then I am on the home page
    And I see "You are not authorized to perform this action"
