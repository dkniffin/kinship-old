Feature: Source deletion

  As an editor
  So that I can provide correct information
  I should be able to delete sources

  Background:
    Given I am logged in as an editor
      And the database is seeded with the following sources:
    | title       | url                           | citation_body |
    | 2130 Census | http://census.org/2030-census | some people lived somewhere |

  Scenario: Delete source
    When I visit the source index page
    Then I see "2130 Census"
    When I click "Destroy"
    Then I am on the source index page
      And I see a success message "Source was successfully deleted"
      And I don't see "2130 Census"
