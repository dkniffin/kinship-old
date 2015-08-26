Feature: Person Interaction
  Scenario: A member can see a person
    Given I am logged in as a member
    And there is 1 person in the database
    When I visit the person index page
    Then I see the person

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

  Scenario: An editor can edit a Person
    Given I am logged in as an editor
    And there is 1 person in the database
    When I visit the edit page for that person
    And I enter "Qwertyuiop" for "First name"
    And I click "Submit"
    Then the person's first name should be "Qwertyuiop"
    And I am on the person show page
    And I see "Qwertyuiop"

  @javascript
  Scenario: An editor can delete a Person
    Given I am logged in as an editor
    And there is a person with name "John Smith"
    When I visit the show page for that person
    And I click "Delete"
    And I confirm the prompt
    Then I am on the person index page
    And I see "John Smith has been deleted"
    And the person no longer exists
