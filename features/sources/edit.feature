Feature: Source modification

  As an editor
  So that I can provide correct information
  I should be able to edit sources

  Background:
    Given I am logged in as an editor
      And the database is seeded with the following sources:
    | title       | url                           | citation_body |
    | 2130 Census | http://census.org/2030-census | some people lived somewhere |

  Scenario: Successful edit
    When I visit "/sources/1"
      And I click "Edit"
    Then I am on the source edit page
      And "Title" is filled in with "2130 Census"
      And "Url" is filled in with "http://census.org/2030-census"
      And "Citation body" is filled in with "some people lived somewhere"
    When I enter "2131 Census" for "Title"
      And I enter "http://census.org/2031-census" for "Url"
      And I enter "nobody lived anywhere" for "Citation body"
      And I click "Submit"
    Then I am on the source show page
      And I see a success message "Source was successfully updated"
      And I see "2131 Census"
      And I see "http://census.org/2031-census"
      And I see "nobody lived anywhere"
