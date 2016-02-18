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
    When I visit "/people/1"
      And I click "Details"
      And I click "Edit Event" for the event "Birth"
      And I select "2130 Census" for "Source"
      And I click "Submit"
    Then I am on "/people/1"
      And I see "Birth was successfully updated"
    When I click "Details"
    Then I see "2130 Census"

  @javascript
  Scenario: Add a source for a death
    Given the database is seeded with 1 person
    When I visit "/people/1"
      And I click "Details"
      And I click "Edit Event" for the event "Death"
      And I select "2130 Census" for "Source"
      And I click "Submit"
    Then I am on "/life_event/death/1"
    When I click "Details"
    Then I see "2130 Census"

  @javascript
  Scenario: Add a source for a marriage
    Given the database is seeded with the following people:
    | first_name | last_name |
    | John       | Smith     |
    | Jane       | Doe       |
    When I visit "/people/1"
      And I click "Family"
      And I click "Add Marriage"
      And I select "Jane Doe" for "Spouse 2"
      And I click "Add Source"
      And I select "2130 Census" for "Title"
      And I click "Submit"
      And I click "Details"
    Then I see "2130 Census"
