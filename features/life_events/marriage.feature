Feature: Person Marriage
  Scenario: An editor can add a marriage to a person
    Given I am logged in as an editor
    And there is a person with the name "John Smith"
    And there is a person with the name "Jane Smith"
    When I visit the show page for "John Smith"
    And I click "Family"
    And I click "Add Marriage"
    Then I am on the new marriage page
    And I see "John Smith" as "Spouse 1"
    When I enter "Jane Smith" for "Spouse 2"
    And I click "Submit"
    Then I am on the show page for "John Smith"
    And I see "The marriage between John and Jane Smith has been added."
    When I click "Family"
    Then I see "Spouse: Jane Smith"
