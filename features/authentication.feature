Feature: User Authentication
  Scenario: User successfully authenticates
    Given I have an account on the site
    When I visit the login path
    Then I am presented with a login page
    When I enter my email
    And I enter my password
    And I click submit
    Then I am redirected to the home page

  Scenario: User enters invalid authentication information
    Given I have an account on the site
    When I visit the login path
    Then I am presented with a login page
    When I enter my email
    And I enter the wrong password
    And I click submit
    Then I am notified that my password is incorrect
