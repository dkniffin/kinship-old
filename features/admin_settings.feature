@load-seed-data
Feature: Changing site-wide settings via admin panel
  Scenario: Change the site title
    Given I am logged in as an admin
    When I visit the admin settings page
    And I fill in "Testing Title" for "Site title"
    And I click "Save Settings"
    Then I see "Settings was successfully updated."
    When I visit the root path
    Then I see "Testing Title"

  Scenario: Change the Homepage Blurb
    Given I am logged in as an admin
    When I visit the admin settings page
    And I fill in "Meh Meh Meh" for "Homepage blurb"
    And I click "Save Settings"
    Then I see "Settings was successfully updated"
    When I visit the root path
    Then I see "Meh Meh Meh"
