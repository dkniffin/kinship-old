Feature: Deleting people

  As an editor
  So that I can provide correct information
  I can delete people

  @javascript
  Scenario: An editor can delete a Person
    Given I am logged in as an editor
      And there is a person with the name "John Smith"
    When I visit "/people/1"
      And I click "Delete"
      And I confirm the prompt
    Then I am on the person index page
      And I see a success message "Person was successfully destroyed"
