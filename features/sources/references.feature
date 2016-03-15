Feature: Reference creation

  As an editor,
  So that I can provide sources for the events in the site
  I should be able to add a source for an event

  Background:
    Given I am logged in as an editor
      And the database is seeded with the following source:
    | title       | url                           | citation_body |
    | 2130 Census | http://census.org/2030-census | some people lived somewhere |

  @javascript
  Scenario: Add a source for a birth
    Given the database is seeded with 1 person
    When I visit the show page for the first person
      And I click "Details"
      And I click "Edit Event" for the event "Birth"
      And I select "2130 Census" for "Source"
      And I click "Submit"
    Then I am on the person show page
      And I see "Birth was successfully updated"
    When I click "Details"
    Then I see "2130 Census"

  @javascript
  Scenario: Add a source for a death
    Given there is a person with the name "John Smith"
      And "John Smith" died on "2005-01-01"
    When I visit the show page for the first person
      And I click "Details"
      And I click "Edit Event" for the event "Death"
      And I select the date "2010-01-02" for "Date"
      And I select "2130 Census" for "Source"
      And I click "Submit"
    Then I am on the person show page
    When I click "Details"
    Then I see "2130 Census"

  @javascript
  Scenario: Add a source for a marriage
    Given the database is seeded with the following people:
    | first_name | last_name |
    | John       | Smith     |
    | Jane       | Doe       |
      And there is a marriage between "John Smith" and "Jane Doe"
    When I visit the show page for the first person
      And I click "Details"
      And I click "Edit Event" for the event "Marriage"
      And I select "2130 Census" for "Source"
      And I click "Submit"
      And I visit the show page for the first person
    When I click "Details"
    Then I see "2130 Census"
