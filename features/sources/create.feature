Feature: Source creation

  As an editor
  So that I can back up the claims I make
  I should be able to create sources

  Background:
    Given I am logged in as an editor

  Scenario: Successful creation
    When I visit the new source page
      And I fill in valid source data
      And I click "Submit"
    Then I am on the source show page
      And I see a success message "Source was successfully created"
      And there is a source in the database

  Scenario: Missing title (invalid)
    When I visit the new source page
      And I fill in valid source data
      And I enter "" for "Title"
      And I click "Submit"
    Then the "Title" field has the error "can't be blank"
      And there are 0 sources in the database

  Scenario: Missing Url (valid)
    When I visit the new source page
      And I fill in valid source data
      And I enter "" for "Url"
      And I click "Submit"
    Then I am on the source show page
      And I see a success message "Source was successfully created"
      And there is a source in the database

  Scenario: Missing Citation Body (valid)
    When I visit the new source page
      And I fill in valid source data
      And I enter "" for "Citation body"
      And I click "Submit"
    Then I am on the source show page
      And I see a success message "Source was successfully created"
      And there is a source in the database
