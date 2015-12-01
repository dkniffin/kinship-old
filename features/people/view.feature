Feature: Viewing people

  As a member
  So that I can get the information I seek
  I can view information about people

  Background:
    Given I am logged in as a member
      # TODO: change this to a table, and check that the show page has the right stuff
      And there is 1 person in the database

  Scenario: A member can view people
    When I visit the person index page
    Then I see the person
