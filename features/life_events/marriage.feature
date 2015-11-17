Feature: Person Marriage

  As an editor
  So that I can input correct information
  I should be able to add and update marriage information

  Background:
    Given I am logged in as an editor

  Scenario: Add marriage between two existing people
    Given the following people exist:
      | first_name | last_name | gender |
      | John       | Jacob     | M      |
      | Jane       | Smith     | F      |
    When I visit the show page for "John Jacob"
      And I click "Family"
      And I click "Add Marriage"
    Then I am on the new marriage page
      And "Spouse 1" is filled in with "John Jacob"
    When I select "Jane Smith" for "Spouse 2"
      And I select the date "1/1/2011" for "Date"
      And I click "Submit"
    Then I am on the marriage show page
      And I see "The marriage between John Jacob and Jane Smith was successfully created."
    When I visit the show page for "John Jacob"
      And I click "Family"
    Then I see "Spouse"
      And I see "Jane Smith"
      And I see the date "1/1/2011"

  @javascript
  Scenario: Add marriage between an existing person and a new person
    Given the following person exists:
      | first_name | last_name | gender |
      | John       | Jacob     | M      |
    When I visit the show page for "John Jacob"
      And I click "Family"
      And I click "Add Marriage"
    Then I am on the new marriage page
      And "Spouse 1" is filled in with "John Jacob"
    When I select "New Person" for "Spouse 2"
    When I enter the following details for a new person:
      | first_name | last_name | gender |
      | Susie      | Sanders   | F      |
      And I select the date "2/2/2012" for "Date"
      And I click "Submit"
    Then I am on the marriage show page
      And I see "The marriage between John Jacob and Susie Sanders was successfully created."
    When I visit the show page for "John Jacob"
      And I click "Family"
    Then I see "Spouse"
      And I see "Susie Sanders"
      And I see the date "2/2/2012"

  Scenario: Update existing marriage
    Given the following people exist:
        | first_name | last_name | gender |
        | John       | Jacob     | M      |
        | Susie      | Smith     | F      |
        | George     | Gant      | M      |
        | Betty      | Baker     | F      |
      And there is a marriage between "John Jacob" and "Susie Smith"
    # TODO:
    # When I visit the show page for "John Jacob"
      # And I click "Family"
      # And I click the marriage
    # When I visit "/life_event/marriages/1"
    # Then I am on the marriage show page
    # When I click "Edit"
    When I visit "/life_event/marriages/1/edit"
    # Edit Spouse 1
    And I select "George Gant" for "Spouse 1"
      And I click "Submit"
    Then I am on the marriage show page
      And I see "The marriage between George Gant and Susie Smith has been updated."
    # Edit Spouse 2
    # When I click "Edit"
    When I visit "/life_event/marriages/1/edit"
      And I select "Betty Baker" for "Spouse 2"
      And I click "Submit"
    Then I am on the marriage show page
      And I see "The marriage between George Gant and Betty Baker has been updated."
    # Edit the date
    # When I click "Edit"
    When I visit "/life_event/marriages/1/edit"
      And I select the date "3/3/2012" for "Date"
      And I click "Submit"
    Then I see "The marriage between George Gant and Betty Baker has been updated."
      And I see the date "3/3/2012"

  # Scenario: Marriages require two people
  #   Given the following people exist:
  #       | first_name | last_name | gender |
  #       | John       | Jacob     | M      |
  #       | Jane       | Smith     | F      |
  #     And there is a marriage between "John Jacob" and "Jane Smith"
  #   When I visit the show page for "John Jacob"
  #   Then TODO
