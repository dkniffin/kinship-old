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

  Scenario: Change the map settings
    Given I am logged in as an admin
    And the database is seeded with 1 person
    When I visit the admin settings page
    And I fill in "https://{s}.tiles.mapbox.com/v4/mapbox.streets/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoib2RkaXR5b3ZlcnNlZXIxMyIsImEiOiIwTEp5a1JnIn0.kzeYyqB2YOj2XXXECKKnJg" for "Map tile url"
    And I fill in "40.597,-95.889" for "Map lat lng"
    And I fill in "5" for "Map zoom"
    And I click "Save Settings"
    Then I see "Settings was successfully updated"
    And the map_tile_url setting is "https://{s}.tiles.mapbox.com/v4/mapbox.streets/{z}/{x}/{y}.png?access_token=pk.eyJ1Ijoib2RkaXR5b3ZlcnNlZXIxMyIsImEiOiIwTEp5a1JnIn0.kzeYyqB2YOj2XXXECKKnJg"
    And the map_lat_lng setting is "40.597,-95.889"
    And the map_zoom setting is "5"
