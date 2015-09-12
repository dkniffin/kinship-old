Feature: An editor can fill in details about a person's birth
  Scenario: At Person creation
    Given I am logged in as an editor
    When I visit the new person page
    And I fill in valid person data
    And I fill in "1/1/1880" for "Birth Date"
    #And I fill in "Durham, NC" for "Birth Place"
    And I click "Submit"
    Then I am on the person show page
    And I see the person
    And I see the date "1/1/1880"
    #And I see the place "Durham, NC"
