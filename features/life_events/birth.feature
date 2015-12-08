Feature: Person Birth
  Scenario: An editor can set birth info at Person creation
    Given I am logged in as an editor
    When I visit the new person page
      And I fill in valid person data
      And I enter "1/1/1880" for "Birth Date"
      #And I fill in "Durham, NC" for "Birth Place"
      And I click "Submit"
    Then I am on the person show page
      And I see the person
      And I see the date "1/1/1880"
      #And I see the place "Durham, NC"

  Scenario: An editor can modify birth info after Person creation
    Given I am logged in as an editor
      And the database is seeded with 1 person
      And I remember the last person as "person 1"
    When I visit the edit page for "person 1"
      And I enter "2/2/1900" for "Birth Date"
      And I click "Submit"
    Then I am on the person show page
      And I see the person
      And I see the date "2/2/1900"
