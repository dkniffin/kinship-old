Feature: Editing people

  As an editor,
  So that I can provide correct information
  I can edit people

  Scenario: An editor can edit a Person
    Given I am logged in as an editor
      And there is 1 person in the database
    When I visit the edit page for that person
      And I enter "Qwertyuiop" for "First name"
      And I click "Submit"
    Then the person's first name should be "Qwertyuiop"
      And I am on the person show page
      And I see "Qwertyuiop"
