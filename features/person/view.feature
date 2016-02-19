Feature: Viewing people

  As a member
  So that I can get the information I seek
  I can view information about people

  Background:
    Given I am logged in as a member
      And there is a person with the name "John Smith"

  Scenario: A member can view people
    When I visit the person index page
    Then the table has the person "John Smith"

  # TODO: search
  # TODO: sort
  # TODO: pagination
