Feature: Source viewing

  As a member
  So that I can verify information
  I should be able to see sources

  Background:
    Given I am logged in as an editor
      And the database is seeded with the following sources:
    | title       | url                           | citation_body |
    | 2130 Census | http://census.org/2030-census | some people lived somewhere |
    | 2135 Census | | |
    | 2120 Census | | |
      And the database is seeded with 26 sources

  Scenario: Index page
    When I visit the source index page
    Then I see a table of sources
      And I see "2130 Census"
      And the table of sources is sorted by "Title"
      And the table is paginated

  Scenario: Show page
    When I visit the show page for the first source
    Then I see "2130 Census"
      And I see "http://census.org/2030-census"
      And I see "some people lived somewhere"
