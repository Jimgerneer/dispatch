Feature: Main page functionality

  Scenario: Viewing index
    Given I am on the index page
    And I file a report against a player
    And I open that player's case
    Then I should see that report
