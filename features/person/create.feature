Feature: Person creation

  As an editor
  So that I can information for a person
  I can create people

  Scenario: An editor can create a person
    Given I am logged in as an editor
    When I visit the new person page
      And I enter "Joe" for "First"
      And I enter "Smith" for "Last"
      And I click "Submit"
    Then I am on the person show page
      And I see "Joe Smith"
    When I visit the person index page
    Then I see "Joe Smith"
