Feature: User Authentication
  Scenario: An unapproved user can't log in
    Given I have an unapproved account
    When I visit the login path
    And I enter my email
    And I enter my password
    And I click the "Log in" button
    Then I see a notice message "Your account has not been approved by an administrator yet."

  Scenario: User successfully authenticates
    Given I have a member account on the site
    And my account has been approved
    When I visit the login path
    Then I am presented with a login page
    When I enter my email
    And I enter my password
    And I click "submit"
    Then I am redirected to the home page

  Scenario: User enters invalid authentication information
    Given I have a member account on the site
    When I visit the login path
    Then I am presented with a login page
    When I enter my email
    And I enter the wrong password
    And I click "submit"
    Then I am notified that my password is incorrect
