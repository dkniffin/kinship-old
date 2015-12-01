Feature: Person creation

  As an editor
  So that I can information for a person
  I can create people

  Scenario: An editor can create a person
    Given I am logged in as an editor
    When I visit the new person page
      And I fill in valid person data
      And I click "Submit"
    Then the person should be created
      And I am on the person show page
      And I see the person
    When I visit the person index page
    Then I see the person
