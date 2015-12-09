Feature: Editing people

  As an editor,
  So that I can provide correct information
  I can edit people

  Scenario: An editor can edit a Person
    Given I am logged in as an editor
      And the database is seeded with 1 person
    When I visit "/people/1/edit"
      And I enter "Qwertyuiop" for "First name"
      And I click "Submit"
    Then I am on the person show page
      And I see "Qwertyuiop"
